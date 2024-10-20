import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/due_payment_model.dart';
import 'package:due_kasir/model/expenses_model.dart';
import 'package:due_kasir/model/inventory_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/presence_model.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/model/request_model.dart';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/rent_model.dart';

class SupabaseHelper {
  static final SupabaseClient supabase = Supabase.instance.client;

  Future<AuthModel> authUser({Users? val}) async {
    final user = supabase.auth.currentUser;
    if (val != null) {
      getIt.get<SellingController>().kasir.value = val;
      return AuthModel.fromJson(val.toJson());
    } else if (user != null) {
      final response = await getCurrentUserProfile();
      final authModel = AuthModel.fromJson(response!.toJson());
      getIt.get<SellingController>().kasir.value = authModel.user;
      return authModel;
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<Users?> getCurrentUserProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final response =
        await supabase.from('users').select().eq('id', userId).single();

    return Users.fromMap(response);
  }

  Future<List<Inventory>> getInventoryAll({String? value}) async {
    final result = await supabase
        .from('inventory')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    List<dynamic> filteredResult = result;

    if (value != null) {
      filteredResult = result
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    return filteredResult.map((val) => Inventory.fromJson(val)).toList();
  }

  Future<List<Inventory>> getOutStock() async {
    final response =
        await supabase.from('inventory').select().lte('jumlah_barang', 1);

    return response.map((e) => Inventory.fromMap(e)).toList();
  }

  addInventory(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('inventory').insert(data).then((value) {
      log('success add inventory $value');
    }).catchError((error) {
      log('error add inventory $error');
    });
  }

  removeInventory(int id) async {
    await supabase.from('inventory').select().eq("id", id).then((value) async {
      await supabase.from('inventory').delete().eq('id', id);
    });
  }

  Future<Inventory?> searchByBarcode(String value) async {
    final response = await supabase
        .from('inventory')
        .select()
        .ilike('code', '%$value%')
        .single();

    return Inventory.fromMap(response);
  }

  Future<List<Inventory>> searchInventorys({String? value}) async {
    final query = supabase.from('inventory').select();

    if (value != null) {
      query.or('nama.ilike.%$value%,code.ilike.%$value%');
    }

    final response = await query;
    return response.map((e) => Inventory.fromMap(e)).toList();
  }

  updateInventory(Inventory item) async {
    await supabase
        .from('inventory')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toMap());
      } else {
        await supabase
            .from('inventory')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  Future<void> addAllInventory(List<Inventory> vals) async {
    for (var val in vals) {
      if (supabase.auth.currentUser != null) {
        await supabase.from('inventory').insert(val.toJson()).then((value) {
          log('success add inventory $value');
        }).catchError((error) {
          log('error add inventory $error');
        });
      }
    }
  }

  // customer
  Future<List<Customer>> getCustomerAll({String? name}) async {
    final query = supabase
        .from('customer')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (name != null) {
      query.ilike('name', '%$name%');
    }

    final response = await query;
    return response.map((e) => Customer.fromMap(e)).toList();
  }

  addCustomer(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('customer').insert(data).then((value) {
      log('success add customer $value');
    }).catchError((error) {
      log('error add customer $error');
    });
  }

  removeCustomer(int id) async {
    await supabase.from('customer').select().eq("id", id).then((value) async {
      await supabase.from('customer').delete().eq('id', id);
    });
  }

  Future<bool> getCustomerById(int id) async {
    final res = await supabase.from('customer').select().eq("id", id);
    return res.isNotEmpty;
  }

  updateCustomer(Customer item) async {
    await supabase
        .from('customer')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toMap());
      } else {
        await supabase
            .from('customer')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  Future<List<Report>> getRepots({DateTime? start, DateTime? end}) async {
    List<Report> allReport = [];

    List<Map<String, dynamic>> result;
    if (start != null && end != null) {
      result = await supabase
          .from('report')
          .select()
          .eq('user', supabase.auth.currentUser!.id)
          .gt('createdAt', start.toIso8601String())
          .lt('createdAt', end.toIso8601String());
    } else {
      result = await supabase
          .from('report')
          .select()
          .eq('user', supabase.auth.currentUser!.id);
    }

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        final List<dynamic> convertItem = jsonDecode(val['items']);
        List<Inventory> listProduct = [];
        await Future.forEach(convertItem, (p) async {
          listProduct.add(Inventory.fromJson(p));
        });

        allReport.add(
          Report(
            id: val['id'],
            pembeli: val['pembeli'],
            diskon: val['diskon'].toDouble(),
            kasir: val['kasir'],
            keterangan: val['keterangan'],
            totalItem: val['totalItem'],
            totalHarga: val['totalHarga'].toDouble(),
            createdAt: DateTime.parse(val['createdAt']),
            items: listProduct,
          ),
        );
      });
    }

    return allReport;
  }

  Future<Map<DateTime, List<Report>>> getSalesByDate({
    required DateTime start,
    required DateTime end,
  }) async {
    final response = await supabase
        .from('report')
        .select()
        .gte('createdAt', start.toIso8601String())
        .lte('createdAt', end.toIso8601String());

    final List<Report> reports =
        response.map((e) => Report.fromMap(e)).toList();

    final Map<DateTime, List<Report>> listOfOrders =
        reports.groupListsBy((report) {
      final dateTime = report.createdAt;
      return DateTime(dateTime.year, dateTime.month, dateTime.day);
    });

    return listOfOrders;
  }

  Future<Map<int, List<Report>>> getReportsByUser() async {
    final response = await supabase
        .from('report')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    final reports = response.map((e) => Report.fromMap(e)).toList();

    final Map<int, List<Report>> reportsByUser = {};
    for (var report in reports) {
      if (!reportsByUser.containsKey(report.kasir)) {
        reportsByUser[report.kasir!] = [];
      }
      reportsByUser[report.kasir]!.add(report);
    }

    return reportsByUser;
  }

  addReport(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('report').insert(data).then((value) {
      log('success add inventory $value');
    }).catchError((error) {
      log('error add inventory $error');
    });
  }

  Future<List<Report>> getReportById({
    required DateTime start,
    required DateTime end,
    int? userId,
  }) async {
    final query = supabase
        .from('report')
        .select()
        .gte('date', start.toIso8601String())
        .lte('date', end.toIso8601String());

    if (userId != null) {
      query.eq('user_id', userId);
    }

    final res = await query;
    return res.map((json) => Report.fromMap(json)).toList();
  }

  removeReport(int id) async {
    await supabase.from('report').select().eq("id", id).then((value) async {
      await supabase.from('report').delete().eq('id', id);
    });
  }

  updateReport(Report item) async {
    await supabase
        .from('report')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toMap());
      } else {
        await supabase
            .from('report')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // presense
  addPresense(Map data) async {
    data.putIfAbsent('belong', () => supabase.auth.currentUser!.id);
    await supabase.from('presense').insert(data).then((value) {
      log('success add presense $value');
    }).catchError((error) {
      log('error add presense $error');
    });
  }

  Future<bool> getPresenseById(int id) async {
    final res = await supabase.from('presense').select().eq("id", id);
    return res.isNotEmpty;
  }

  Future<List<PresenseModel>> getPresense({
    required DateTime? start,
    required DateTime? end,
  }) async {
    List<PresenseModel> allPresense = [];

    final query = supabase
        .from('presense')
        .select()
        .eq('belong', supabase.auth.currentUser!.id);

    if (start != null && end != null) {
      query.gt('createdAt', start).lt('createdAt', end);
    } else if (start != null) {
      query.gte('createdAt', start);
    } else if (end != null) {
      query.lte('createdAt', end);
    }

    final result = await query;

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        allPresense.add(PresenseModel.fromMap(val));
      });
    }
    return allPresense;
  }

  // rent item
  addRentItem(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('rent_items').insert(data).then((value) {
      log('success add presense $value');
    }).catchError((error) {
      log('error add presense $error');
    });
  }

  Future<RentItems?> getRentItemById(int id) async {
    final response =
        await supabase.from('rent_items').select().eq('id', id).single();

    return RentItems.fromMap(response);
  }

  Future<List<RentItems>> getRentItems() async {
    List<RentItems> rentItems = [];

    final result = await supabase
        .from('rent_items')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        rentItems.add(RentItems.fromMap(val));
      });
    }
    return rentItems;
  }

  Future<List<Rent>> getRentRevenue() async {
    final response = await supabase.from('rent').select().eq('paid', true);
    return response.map((e) => Rent.fromMap(e)).toList();
  }

  removeRentItem(int id) async {
    await supabase.from('rent_items').select().eq("id", id).then((value) async {
      await supabase.from('rent_items').delete().eq('id', id);
    });
  }

  updateRentItem(RentItems item) async {
    await supabase
        .from('rent_items')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addRentItem(item.toMap());
      } else {
        await supabase
            .from('rent_items')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // rent
  addRent(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('rent').insert(data).then((value) {
      log('success add presense $value');
    }).catchError((error) {
      log('error add presense $error');
    });
  }

  Future<List<Rent>> getRent() async {
    List<Rent> rentItems = [];

    final result = await supabase
        .from('rent')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        rentItems.add(Rent.fromMap(val));
      });
    }
    return rentItems;
  }

  Future<bool> getRentById(int id) async {
    final res = await supabase.from('rent').select().eq("id", id);
    return res.isNotEmpty;
  }

  updateRent(Rent item) async {
    await supabase.from('rent').select().eq("id", item.id).then((value) async {
      if (value.isEmpty) {
        addRent(item.toMap());
      } else {
        await supabase.from('rent').update(item.toMap()).match({'id': item.id});
      }
    });
  }

  // expenses
  addExpenses(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('expenses').insert(data).then((value) {
      log('success add expanses $value');
    }).catchError((error) {
      log('error add expanses $error');
    });
  }

  removeExpenses(int id) async {
    await supabase.from('expenses').select().eq("id", id).then((value) async {
      await supabase.from('expenses').delete().eq('id', id);
    });
  }

  Future<List<Expenses>> getExpenses({
    required DateTime? start,
    required DateTime? end,
  }) async {
    List<Expenses> expensesItems = [];

    final query = supabase
        .from('expenses')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (start != null && end != null) {
      query
          .gt('createdAt', start.toIso8601String())
          .lt('createdAt', end.toIso8601String());
    } else if (start != null) {
      query.gt('createdAt', start.toIso8601String());
    } else if (end != null) {
      query.lt('createdAt', end.toIso8601String());
    }

    final result = await query;

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        expensesItems.add(Expenses.fromMap(val));
      });
    }
    return expensesItems;
  }

  Future<bool> getExpensesById(int id) async {
    final res = await supabase.from('rent').select().eq("id", id);
    return res.isNotEmpty;
  }

  // store
  addStore(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('store').insert(data).then((value) {
      log('success add store $value');
    }).catchError((error) {
      log('error add store $error');
    });
  }

  Future<StoreModel?> getStore() async {
    final result = await supabase
        .from('store')
        .select()
        .eq('user', supabase.auth.currentUser!.id);
    return result.isEmpty ? null : StoreModel.fromMap(result.first);
  }

  updateStore(StoreModel item) async {
    await supabase.from('store').select().eq("id", item.id).then((value) async {
      if (value.isEmpty) {
        addStore(item.toMap());
      } else {
        await supabase
            .from('store')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // user
  addUsers(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('users').insert(data).then((value) {
      log('success add users $value');
    }).catchError((error) {
      log('error add users $error');
    });
  }

  Future<Users?> getUserById(int id) async {
    final res = await supabase.from('users').select().eq("id", id);
    if (res.isNotEmpty) {
      return Users.fromMap(res.first);
    } else {
      throw Exception('User not found');
    }
  }

  Future<List<Users>> getUsers({String? name}) async {
    List<Users> users = [];

    final query = supabase
        .from('users')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (name != null) {
      query.ilike('name', '%$name%');
    }

    final result = await query;

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        users.add(Users.fromMap(val));
      });
    }
    return users;
  }

  removeUsers(int id) async {
    await supabase.from('users').select().eq("id", id).then((value) async {
      await supabase.from('users').delete().eq('id', id);
    });
  }

  updateUsers(Users item) async {
    await supabase.from('users').select().eq("id", item.id).then((value) async {
      if (value.isEmpty) {
        addUsers(item.toMap());
      } else {
        await supabase
            .from('users')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // salary
  addSalary(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('salary').insert(data).then((value) {
      log('success add presesalarynse $value');
    }).catchError((error) {
      log('error add salary $error');
    });
  }

  removeSalary(int id) async {
    await supabase.from('salary').select().eq("id", id).then((value) async {
      await supabase.from('salary').delete().eq('id', id);
    });
  }

  Future<bool> getSalariesById(int id) async {
    final res = await supabase.from('salary').select().eq("id", id);
    return res.isNotEmpty;
  }

  Future<List<Salary>> getSalarys() async {
    List<Salary> salaryItems = [];

    final result = await supabase
        .from('salary')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        List<ItemSalary> items = [];
        await Future.forEach(val['items'], (p) async {
          items.add(ItemSalary.fromMap(p as Map<String, dynamic>));
        });

        List<ItemSalary> deductions = [];
        if (val['deductions'] != null) {
          await Future.forEach(val['deductions'], (p) async {
            deductions.add(ItemSalary.fromMap(p as Map<String, dynamic>));
          });
        }

        salaryItems.add(
          Salary(
            id: val['id'],
            periode: val['periode'],
            status: val['status'],
            total: val['total'].toInt(),
            userId: val['userId'].toInt(),
            note: val['note'],
            items: items,
            deductions: deductions,
            createdAt: val['createdAt'] != null
                ? DateTime.parse(val['createdAt'])
                : null,
          ),
        );
      });
    }
    return salaryItems;
  }

  updateSalary(Salary item) async {
    await supabase
        .from('salary')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addRent(item.toMap());
      } else {
        await supabase
            .from('salary')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // due payment
  Future<List<DuePayment>> getDuePayment() async {
    List data = [];
    List<DuePayment> duePayments = [];

    final result = await supabase
        .from('due_payment')
        .select()
        .eq('user', supabase.auth.currentUser!.id);
    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async => data.add(val));
    }
    await Future.forEach(data, (val) async {
      duePayments.add(DuePayment.fromJson(val));
    });

    return duePayments;
  }

  addDuePayment(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('due_payment').insert(data).then((value) {
      log('success add due payment $value');
    }).catchError((error) {
      log('error add due payment $error');
    });
  }

  Future<bool> getDuePaymentById(int id) async {
    final res = await supabase.from('due_payment').select().eq("id", id);
    return res.isNotEmpty;
  }

  removeDuePayment(int id) async {
    await supabase
        .from('due_payment')
        .select()
        .eq("id", id)
        .then((value) async {
      await supabase.from('due_payment').delete().eq('id', id);
    });
  }

  updateDuePayment(DuePayment item) async {
    await supabase
        .from('due_payment')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addDuePayment(item.toMap());
      } else {
        await supabase
            .from('due_payment')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }

  // request
  addRequest(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('request').insert(data).then((value) {
      log('success add request $value');
    }).catchError((error) {
      log('error add request $error');
    });
  }

  removeRequest(int id) async {
    await supabase.from('request').select().eq("id", id).then((value) async {
      await supabase.from('request').delete().eq('id', id);
    });
  }

  Future<bool> getRequestId(int id) async {
    final res = await supabase.from('request').select().eq("id", id);
    return res.isNotEmpty;
  }

  Future<List<Request>> getRequests() async {
    List<Request> requestItems = [];

    final result = await supabase
        .from('request')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    await Future.forEach(result, (val) async {
      requestItems.add(Request.fromMap(val));
    });

    return requestItems;
  }

  updateRequest(Request item) async {
    await supabase
        .from('request')
        .select()
        .eq("id", item.id)
        .then((value) async {
      if (value.isEmpty) {
        addRent(item.toMap());
      } else {
        await supabase
            .from('request')
            .update(item.toMap())
            .match({'id': item.id});
      }
    });
  }
}
