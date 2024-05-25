import 'dart:convert';
import 'dart:developer';

import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/due_payment_model.dart';
import 'package:due_kasir/model/expenses_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/presence_model.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/rent_model.dart';

class SupabaseHelper {
  static final SupabaseClient supabase = Supabase.instance.client;

  Future<List<ItemModel>> getInventoryAll() async {
    List data = [];
    List<ItemModel> allInventory = [];

    final result = await supabase
        .from('inventory')
        .select()
        .eq('user', supabase.auth.currentUser!.id);
    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async => data.add(val));
    }
    await Future.forEach(data, (val) async {
      allInventory.add(ItemModel.fromJson(val));
    });

    return allInventory;
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

  updateInventory(ItemModel item) async {
    await supabase
        .from('inventory')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toJson());
      } else {
        await supabase
            .from('inventory')
            .update(item.toJson())
            .match({'id': item.id!});
      }
    });
  }

  // customer
  Future<List<CustomerModel>> getCustomerAll() async {
    List<CustomerModel> allCustomer = [];

    await supabase
        .from('customer')
        .select()
        .eq('user', supabase.auth.currentUser!.id)
        .then(
      (val) {
        for (var element in val) {
          allCustomer.add(CustomerModel.fromJson(element));
        }
      },
    );

    return allCustomer;
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

  updateCustomer(CustomerModel item) async {
    await supabase
        .from('customer')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toJson());
      } else {
        await supabase
            .from('customer')
            .update(item.toJson())
            .match({'id': item.id!});
      }
    });
  }

  Future<List<PenjualanModel>> getRepots(
      {DateTime? start, DateTime? end}) async {
    List<PenjualanModel> allReport = [];

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
        List<ProductItemModel> listProduct = [];
        await Future.forEach(convertItem, (p) async {
          listProduct.add(ProductItemModel.fromJson(p));
        });

        allReport.add(
          PenjualanModel(
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

  addReport(Map data) async {
    data.putIfAbsent('user', () => supabase.auth.currentUser!.id);
    await supabase.from('report').insert(data).then((value) {
      log('success add inventory $value');
    }).catchError((error) {
      log('error add inventory $error');
    });
  }

  Future<bool> getReportById(int id) async {
    final res = await supabase.from('report').select().eq("id", id);
    return res.isNotEmpty;
  }

  removeReport(int id) async {
    await supabase.from('report').select().eq("id", id).then((value) async {
      await supabase.from('report').delete().eq('id', id);
    });
  }

  updateReport(PenjualanModel item) async {
    await supabase
        .from('report')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addInventory(item.toJson());
      } else {
        await supabase
            .from('report')
            .update(item.toJson())
            .match({'id': item.id!});
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

  Future<List<PresenceModel>> getPresense() async {
    List<PresenceModel> allPresense = [];

    final result = await supabase
        .from('presense')
        .select()
        .eq('belong', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        allPresense.add(PresenceModel.fromJson(val));
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

  Future<bool> getRentItemById(int id) async {
    final res = await supabase.from('rent_items').select().eq("id", id);
    return res.isNotEmpty;
  }

  Future<List<RentItemModel>> getRentItems() async {
    List<RentItemModel> rentItems = [];

    final result = await supabase
        .from('rent_items')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        rentItems.add(RentItemModel.fromJson(val));
      });
    }
    return rentItems;
  }

  removeRentItem(int id) async {
    await supabase.from('rent_items').select().eq("id", id).then((value) async {
      await supabase.from('rent_items').delete().eq('id', id);
    });
  }

  updateRentItem(RentItemModel item) async {
    await supabase
        .from('rent_items')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addRentItem(item.toJson());
      } else {
        await supabase
            .from('rent_items')
            .update(item.toJson())
            .match({'id': item.id!});
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

  Future<List<RentModel>> getRent() async {
    List<RentModel> rentItems = [];

    final result = await supabase
        .from('rent')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        rentItems.add(RentModel.fromJson(val));
      });
    }
    return rentItems;
  }

  Future<bool> getRentById(int id) async {
    final res = await supabase.from('rent').select().eq("id", id);
    return res.isNotEmpty;
  }

  updateRent(RentModel item) async {
    await supabase.from('rent').select().eq("id", item.id!).then((value) async {
      if (value.isEmpty) {
        addRent(item.toJson());
      } else {
        await supabase
            .from('rent')
            .update(item.toJson())
            .match({'id': item.id!});
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

  Future<List<ExpensesModel>> getExpenses() async {
    List<ExpensesModel> expensesItems = [];

    final result = await supabase
        .from('expenses')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        expensesItems.add(ExpensesModel.fromJson(val));
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
    return result.isEmpty ? null : StoreModel.fromJson(result.first);
  }

  updateStore(StoreModel item) async {
    await supabase
        .from('store')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addStore(item.toJson());
      } else {
        await supabase
            .from('store')
            .update(item.toJson())
            .match({'id': item.id!});
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

  Future<bool> getUserById(int id) async {
    final res = await supabase.from('users').select().eq("id", id);
    return res.isNotEmpty;
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];

    final result = await supabase
        .from('users')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        users.add(UserModel.fromJson(val));
      });
    }
    return users;
  }

  removeUsers(int id) async {
    await supabase.from('users').select().eq("id", id).then((value) async {
      await supabase.from('users').delete().eq('id', id);
    });
  }

  updateUsers(UserModel item) async {
    await supabase
        .from('users')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addUsers(item.toJson());
      } else {
        await supabase
            .from('users')
            .update(item.toJson())
            .match({'id': item.id!});
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

  Future<List<SalaryModel>> getSalarys() async {
    List<SalaryModel> salaryItems = [];

    final result = await supabase
        .from('salary')
        .select()
        .eq('user', supabase.auth.currentUser!.id);

    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async {
        List<ItemSalary> items = [];
        await Future.forEach(val['items'], (p) async {
          items.add(ItemSalary.fromJson(p));
        });

        List<ItemSalary> deductions = [];
        if (val['deductions'] != null) {
          await Future.forEach(val['deductions'], (p) async {
            deductions.add(ItemSalary.fromJson(p));
          });
        }

        salaryItems.add(
          SalaryModel(
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

  updateSalary(SalaryModel item) async {
    await supabase
        .from('salary')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addRent(item.toJson());
      } else {
        await supabase
            .from('salary')
            .update(item.toJson())
            .match({'id': item.id!});
      }
    });
  }

  // due payment
  Future<List<DuePaymentModel>> getDuePayment() async {
    List data = [];
    List<DuePaymentModel> duePayments = [];

    final result = await supabase
        .from('due_payment')
        .select()
        .eq('user', supabase.auth.currentUser!.id);
    if (result.isNotEmpty) {
      await Future.forEach(result, (val) async => data.add(val));
    }
    await Future.forEach(data, (val) async {
      duePayments.add(DuePaymentModel.fromJson(val));
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

  updateDuePayment(DuePaymentModel item) async {
    await supabase
        .from('due_payment')
        .select()
        .eq("id", item.id!)
        .then((value) async {
      if (value.isEmpty) {
        addDuePayment(item.toJson());
      } else {
        await supabase
            .from('due_payment')
            .update(item.toJson())
            .match({'id': item.id!});
      }
    });
  }
}
