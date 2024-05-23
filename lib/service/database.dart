import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/due_payment_model.dart';
import 'package:due_kasir/model/expenses_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/presence_model.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/model/rent_model.dart';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  late Future<Isar> db;

  Database() {
    db = openDB();
  }

  final SupabaseHelper _supabaseHelper = SupabaseHelper();

  // Auth Local
  Future<void> loginUser(AuthModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.authModels.putSync(val));
  }

  Future<void> changeUser(AuthModel val) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.authModels.put(val);
      await val.user.save();
    });
  }

  // User
  Future<AuthModel> authUser() async {
    final isar = await db;
    IsarCollection<AuthModel> authCollection = isar.collection<AuthModel>();
    final users = await authCollection.where().findAll();
    getIt.get<SellingController>().kasir.value = users.first.user.value;
    return users.first;
  }

  Future<void> addNewUser(UserModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.userModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addUsers(val.toJson());
    }
  }

  Future<void> deleteUser(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.userModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeUsers(val);
    }
  }

  Future<void> updateUser(UserModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() => isar.userModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateUsers(val);
    }
  }

  Future<List<UserModel>> getUsers({String? name}) async {
    final isar = await db;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    final users = userCollection
        .filter()
        .namaContains(name ?? '', caseSensitive: false)
        .findAll();
    return users;
  }

  Future<UserModel?> getUserById(int id) async {
    final isar = await db;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    final users = userCollection.get(id);
    return users;
  }

  Future<void> clearUser() async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    isar.writeTxn<void>(() => customerCollection.clear());
  }

  insertUserFresh(List<UserModel> userList) async {
    final isar = await db;
    await clearUser();
    if (userList.isNotEmpty) {
      await Future.forEach(
          userList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.userModels.put(val)));
      await getUsers();
    }
  }

  Future<void> syncUsers() async {
    final users = await getUsers();
    if (users.isNotEmpty) {
      await Future.forEach(users, (element) async {
        final res = await _supabaseHelper.getUserById(element.id!);
        if (res == false) {
          _supabaseHelper.addUsers(element.toJson());
        }
      });
      final res = await _supabaseHelper.getUsers();
      if (res.isNotEmpty) {
        insertUserFresh(res);
      }
    } else {
      final res = await _supabaseHelper.getUsers();
      if (res.isNotEmpty) {
        insertUserFresh(res);
      }
    }
  }

  // Customer
  Future<void> addNewCustomer(CustomerModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.customerModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addCustomer(val.toJson());
    }
  }

  Future<void> deleteCustomer(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.customerModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeCustomer(val);
    }
  }

  Future<void> updateCustomer(CustomerModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.customerModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateCustomer(val);
    }
  }

  Future<List<CustomerModel>> getCustomers({String? name}) async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    final customer = customerCollection
        .filter()
        .namaContains(name ?? '', caseSensitive: false)
        .findAll();
    return customer;
  }

  Future<void> syncCustomers() async {
    final customers = await getCustomers();
    if (customers.isNotEmpty) {
      await Future.forEach(customers, (val) async {
        final res = await _supabaseHelper.getCustomerById(val.id!);
        if (res == false) {
          await _supabaseHelper.addCustomer(val.toJson());
        }
      });
      final res = await _supabaseHelper.getCustomerAll();
      if (res.isNotEmpty) {
        await insertCustomerFresh(res);
      }
    } else {
      final res = await _supabaseHelper.getCustomerAll();
      if (res.isNotEmpty) {
        await insertCustomerFresh(res);
      }
    }
  }

  Future<void> clearCustomer() async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    isar.writeTxn<void>(() => customerCollection.clear());
  }

  insertCustomerFresh(List<CustomerModel> customerList) async {
    final isar = await db;
    await clearCustomer();
    if (customerList.isNotEmpty) {
      await Future.forEach(
          customerList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.customerModels.put(val)));
    }
    await getCustomers();
  }

  Future<void> checkCustomerSynced() async {
    final customers = await getCustomers();
    if (customers.isNotEmpty) {
      for (CustomerModel element in customers) {
        final res = await _supabaseHelper.getCustomerById(element.id!);
        if (res == false) {
          _supabaseHelper.addCustomer(element.toJson());
        }
      }
    } else {
      getCustomers();
    }
  }

  Future<CustomerModel?> getCustomerById(int id) async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    final users = customerCollection.get(id);
    return users;
  }

  // inventory
  Future<void> addInventory(ItemModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addInventory(val.toJson());
    }
  }

  Future<void> addAllInventory(List<ItemModel> vals) async {
    final isar = await db;
    for (var val in vals) {
      val.isSynced = isDeviceConnected.value;
      isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
      if (isDeviceConnected.value) {
        _supabaseHelper.addInventory(val.toJson());
      }
    }
  }

  Future<void> deleteInventory(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.itemModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeInventory(val);
    }
  }

  Future<void> updateInventory(ItemModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.itemModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateInventory(val);
    }
  }

  Future<List<ItemModel>> getInventorys({String? value}) async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    return await inventoryCollection
        .filter()
        .group((q) => q
            .namaContains(value ?? '', caseSensitive: false)
            .or()
            .codeContains(value ?? '', caseSensitive: false))
        .findAll();
  }

  insertInventoryFresh(List<ItemModel> inventoryList) async {
    final isar = await db;
    await clearInventory();
    if (inventoryList.isNotEmpty) {
      await Future.forEach(
          inventoryList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.itemModels.put(val)));
    }
  }

  Future<List<ItemModel>> searchInventorys({String? value}) async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    final items = inventoryCollection
        .filter()
        .group((q) => q
            .namaContains(value ?? '', caseSensitive: false)
            .or()
            .codeContains(value ?? '', caseSensitive: false))
        .findAll();
    return items;
  }

  Future<ItemModel?> searchByBarcode(String value) async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    final items = await inventoryCollection
        .filter()
        .group((q) => q.codeContains(value, caseSensitive: false))
        .findFirst();
    return items;
  }

  void updateInventorySync(ItemModel inventory) async {
    final isar = await db;
    inventory.isSynced = true;
    await isar.writeTxn(() async {
      await isar.itemModels.put(inventory);
    });
  }

  getUnsyncedInventoryData() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    List<ItemModel?> items =
        await inventoryCollection.filter().isSyncedEqualTo(false).findAll();
    return items;
  }

  Future<void> checkIsInventorySynced() async {
    final inventorys = await searchInventorys();
    if (inventorys.isNotEmpty) {
      List<ItemModel> unsyncedInventory = await getUnsyncedInventoryData();
      if (inventoryController.deleteItemList.value.isNotEmpty) {
        await Future.forEach(inventoryController.deleteItemList.value,
            (element) async => _supabaseHelper.removeInventory(element.id!));
        // for (ItemModel element in inventoryController.deleteItemList.value) {
        //   _supabaseHelper.removeInventory(element.id!);
        // }
        inventoryController.deleteItemList.value.clear();
      }
      if (unsyncedInventory.isNotEmpty) {
        await Future.forEach(unsyncedInventory, (element) async {
          element.isSynced = true;
          await _supabaseHelper.updateInventory(element);
          updateInventorySync(element);
        });
      }
      // refresh
      final res = await _supabaseHelper.getInventoryAll();
      await insertInventoryFresh(res);
    } else {
      final res = await _supabaseHelper.getInventoryAll();
      await insertInventoryFresh(res);
      getInventorys();
    }
  }

  Future<void> clearInventory() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    isar.writeTxn<void>(() => inventoryCollection.clear());
  }

  Future<List<ItemModel>> getOutStock() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    final items = inventoryCollection
        .filter()
        .group((q) => q.jumlahBarangLessThan(1))
        .findAll();
    return items;
  }

  // sales
  Future<void> addPenjualan(PenjualanModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.penjualanModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addReport(val.toJson());
    }
  }

  Future<void> removePenjualan(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() => isar.penjualanModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeReport(val);
    }
  }

  Future<void> clearReport() async {
    final isar = await db;
    IsarCollection<PenjualanModel> reportCollection =
        isar.collection<PenjualanModel>();
    isar.writeTxn<void>(() => reportCollection.clear());
  }

  insertReportFresh(List<PenjualanModel> reportList) async {
    final isar = await db;
    await clearReport();

    if (reportList.isNotEmpty) {
      await Future.forEach(
          reportList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.penjualanModels.put(val)));
    }
  }

  Future<List<PenjualanModel>> getReport(
      {required DateTime start, required DateTime end}) async {
    final isar = await db;
    IsarCollection<PenjualanModel> reportCollection =
        isar.collection<PenjualanModel>();
    if (isDeviceConnected.value) {
      final List<PenjualanModel> res = await _supabaseHelper.getRepots(
        start: start.copyWith(hour: 0, minute: 0, second: 0),
        end: end.copyWith(hour: 23, minute: 59, second: 59),
      );
      final items = await reportCollection
          .where()
          .filter()
          .createdAtBetween(start.copyWith(hour: 0, minute: 0, second: 0),
              end.copyWith(hour: 23, minute: 59, second: 59))
          .findAll();
      if (res.length == items.length || items.length >= res.length) {
        return items;
      } else {
        await insertReportFresh(res);
        final freshItems = await reportCollection
            .where()
            .filter()
            .createdAtBetween(start.copyWith(hour: 0, minute: 0, second: 0),
                end.copyWith(hour: 23, minute: 59, second: 59))
            .findAll();
        return freshItems;
      }
    }
    return [];
  }

  Future<List<PenjualanModel>> getReportToday() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    final items = await inventoryCollection
        .filter()
        .createdAtBetween(
            DateTime.now().copyWith(hour: 0, minute: 0, second: 0),
            DateTime.now().copyWith(hour: 23, minute: 59, second: 59))
        .findAll();
    return items;
  }

  Future<List<PenjualanModel>> getReportYesterday() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    final items = await inventoryCollection
        .filter()
        .createdAtBetween(
            DateTime.now()
                .subtract(const Duration(days: 1))
                .copyWith(hour: 0, minute: 0, second: 0),
            DateTime.now()
                .subtract(const Duration(days: 1))
                .copyWith(hour: 23, minute: 59, second: 59))
        .findAll();
    return items;
  }

  Future<Map<int, List<PenjualanModel>>> getSalesByUser() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    final items = await inventoryCollection.where().findAll();

    final Map<int, List<PenjualanModel>> listOfOrders =
        items.groupListsBy((i) => i.kasir);

    return listOfOrders;
  }

  Future<Map<DateTime, List<PenjualanModel>>> getSalesByDate(
      {required DateTime start, required DateTime end}) async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    List<PenjualanModel> items = inventoryCollection
        .where()
        .filter()
        .createdAtBetween(start.copyWith(hour: 0, minute: 0, second: 0),
            end.copyWith(hour: 23, minute: 59, second: 59))
        .findAllSync();

    final Map<DateTime, List<PenjualanModel>> listOfOrders = items.groupListsBy(
        (order) => DateTime(
            order.createdAt.year, order.createdAt.month, order.createdAt.day));

    return listOfOrders;
  }

  Future<List<PenjualanModel>> getReportAll() async {
    final isar = await db;
    IsarCollection<PenjualanModel> reportCollection =
        isar.collection<PenjualanModel>();
    if (isDeviceConnected.value) {
      final List<PenjualanModel> res = await _supabaseHelper.getRepots();
      final items = await reportCollection.where().findAll();
      if (res.length == items.length) {
        return items;
      } else {
        await insertReportFresh(res);
        final freshItems = await reportCollection.where().findAll();
        return freshItems;
      }
    }
    return [];
  }

  Future<void> checkIsReportSynced() async {
    final reports = await getReportAll();
    if (reports.isNotEmpty) {
      for (PenjualanModel element in reports) {
        final res = await _supabaseHelper.getReportById(element.id!);
        if (res == false) {
          _supabaseHelper.addReport(element.toJson());
        }
      }
    } else {
      getReportAll();
    }
  }

  Future<void> addStore(StoreModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.storeModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateStore(val);
    }
  }

  Future<StoreModel?> getStore() async {
    final isar = await db;
    IsarCollection<StoreModel> storeCollection = isar.collection<StoreModel>();
    final store = storeCollection.where().findFirst();
    return store;
  }

  Future<void> syncStore() async {
    final store = await getStore();
    if (store != null) {
      _supabaseHelper.updateStore(store);
    } else {
      final res = await _supabaseHelper.getStore();
      if (res != null) {
        await addStore(res);
      }
    }
  }

  // presense
  Future<void> addPresense(PresenceModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.presenceModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addPresense(val.toJson());
    }
  }

  Future<List<PresenceModel>> getPresense(
      {required DateTime start, required DateTime end}) async {
    final isar = await db;
    IsarCollection<PresenceModel> presenseCollection =
        isar.collection<PresenceModel>();
    return await presenseCollection
        .where()
        .filter()
        .createdAtBetween(start.copyWith(hour: 0, minute: 0, second: 0),
            end.copyWith(hour: 23, minute: 59, second: 59))
        .findAll();
  }

  // sync presense
  Future<void> presenseSync() async {
    final isar = await db;
    IsarCollection<PresenceModel> presenseCollection =
        isar.collection<PresenceModel>();

    final presense = await presenseCollection.where().findAll();
    if (presense.isNotEmpty) {
      final res = await _supabaseHelper.getPresense();
      if (res.length != presense.length) {
        if (presense.length >= res.length) {
          await Future.forEach(presense, (val) async {
            final res = await _supabaseHelper.getPresenseById(val.id!);
            if (res == false) {
              _supabaseHelper.addPresense(val.toJson());
            }
          });
          final res = await _supabaseHelper.getPresense();
          insertPresenseFresh(res);
        } else {
          insertPresenseFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getPresense();
      insertPresenseFresh(res);
    }
  }

  Future<void> clearPresense() async {
    final isar = await db;
    IsarCollection<PresenceModel> presenseCollection =
        isar.collection<PresenceModel>();
    isar.writeTxn<void>(() => presenseCollection.clear());
  }

  insertPresenseFresh(List<PresenceModel> presenseList) async {
    final isar = await db;
    await clearPresense();

    if (presenseList.isNotEmpty) {
      await Future.forEach(
          presenseList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.presenceModels.put(val)));
    }
  }

  // rent item
  Future<void> addRentItem(RentItemModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.rentItemModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addRentItem(val.toJson());
    }
  }

  Future<List<RentItemModel>> getRentItem() async {
    final isar = await db;
    IsarCollection<RentItemModel> rentItemCollection =
        isar.collection<RentItemModel>();

    return await rentItemCollection.where().findAll();
  }

  Future<RentItemModel?> getRentItemById(int id) async {
    final isar = await db;
    IsarCollection<RentItemModel> rentItemCollection =
        isar.collection<RentItemModel>();
    final rent = rentItemCollection.get(id);
    return rent;
  }

  Future<void> deleteRentItem(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.rentItemModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeRentItem(val);
    }
  }

  Future<void> updateRentItem(RentItemModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.rentItemModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateRentItem(val);
    }
  }

  // sync rent items
  Future<void> rentItemSync() async {
    final rentItems = await getRentItem();
    if (rentItems.isNotEmpty) {
      final res = await _supabaseHelper.getRentItems();
      if (res.length != rentItems.length) {
        if (rentItems.length >= res.length) {
          await Future.forEach(rentItems, (val) async {
            final res = await _supabaseHelper.getRentItemById(val.id!);
            if (res == false) {
              _supabaseHelper.addRentItem(val.toJson());
            }
          });
          final res = await _supabaseHelper.getRentItems();
          insertRentItemsFresh(res);
        } else {
          insertRentItemsFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getRentItems();
      insertRentItemsFresh(res);
    }
  }

  Future<void> clearRentItems() async {
    final isar = await db;
    IsarCollection<RentItemModel> rentItemsCollection =
        isar.collection<RentItemModel>();
    isar.writeTxn<void>(() => rentItemsCollection.clear());
  }

  insertRentItemsFresh(List<RentItemModel> rentItemList) async {
    final isar = await db;
    await clearRentItems();
    if (rentItemList.isNotEmpty) {
      await Future.forEach(
          rentItemList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.rentItemModels.put(val)));
    }
  }

  // rent
  Future<void> addRent(RentModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.rentModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addRent(val.toJson());
    }
  }

  Future<List<RentModel>> getRent() async {
    final isar = await db;
    IsarCollection<RentModel> rentCollection = isar.collection<RentModel>();
    return await rentCollection.where().findAll();
  }

  Future<void> updateRent(RentModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.rentModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateRent(val);
    }
  }

  Future<List<RentModel>> getRentRevenue() async {
    final isar = await db;
    IsarCollection<RentModel> rentCollection = isar.collection<RentModel>();

    return await rentCollection.filter().paidEqualTo(true).findAll();
  }

  // sync rent
  Future<void> rentSync() async {
    final rent = await getRent();
    if (rent.isNotEmpty) {
      final res = await _supabaseHelper.getRent();
      if (res.length != rent.length) {
        if (rent.length >= res.length) {
          await Future.forEach(rent, (val) async {
            final res = await _supabaseHelper.getRentById(val.id!);
            if (res == false) {
              _supabaseHelper.addRent(val.toJson());
            }
          });
          final res = await _supabaseHelper.getRent();
          insertRentFresh(res);
        } else {
          insertRentFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getRent();
      insertRentFresh(res);
    }
  }

  Future<void> clearRent() async {
    final isar = await db;
    IsarCollection<RentModel> rentCollection = isar.collection<RentModel>();
    isar.writeTxn<void>(() => rentCollection.clear());
  }

  insertRentFresh(List<RentModel> rentList) async {
    final isar = await db;
    await clearRent();
    if (rentList.isNotEmpty) {
      await Future.forEach(
          rentList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.rentModels.put(val)));
    }
  }

  // expenses
  Future<void> addExpenses(ExpensesModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.expensesModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addExpenses(val.toJson());
    }
  }

  Future<void> deleteExpenses(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.expensesModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeExpenses(val);
    }
  }

  Future<List<ExpensesModel>> getExpenses(
      {required DateTime start, required DateTime end}) async {
    final isar = await db;
    IsarCollection<ExpensesModel> expensesCollection =
        isar.collection<ExpensesModel>();
    return await expensesCollection
        .where()
        .filter()
        .createdAtBetween(start.copyWith(hour: 0, minute: 0, second: 0),
            end.copyWith(hour: 23, minute: 59, second: 59))
        .findAll();
  }

  // sync expenses
  Future<void> expensesSync() async {
    final isar = await db;
    IsarCollection<ExpensesModel> expensesCollection =
        isar.collection<ExpensesModel>();

    final expenses = await expensesCollection.where().findAll();
    if (expenses.isNotEmpty) {
      final res = await _supabaseHelper.getExpenses();
      if (res.length != expenses.length) {
        if (expenses.length >= res.length) {
          await Future.forEach(expenses, (val) async {
            final res = await _supabaseHelper.getRentById(val.id!);
            if (res == false) {
              _supabaseHelper.addExpenses(val.toJson());
            }
          });
          final res = await _supabaseHelper.getExpenses();
          insertExpensesFresh(res);
        } else {
          insertExpensesFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getExpenses();
      insertExpensesFresh(res);
    }
  }

  Future<void> clearExpenses() async {
    final isar = await db;
    IsarCollection<ExpensesModel> expensesCollection =
        isar.collection<ExpensesModel>();
    isar.writeTxn<void>(() => expensesCollection.clear());
  }

  insertExpensesFresh(List<ExpensesModel> expensesList) async {
    final isar = await db;
    await clearExpenses();

    if (expensesList.isNotEmpty) {
      await Future.forEach(
          expensesList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.expensesModels.put(val)));
    }
  }

  // Salary
  Future<void> addSalary(SalaryModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.salaryModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addSalary(val.toJson());
    }
  }

  Future<List<SalaryModel>> getSalary() async {
    final isar = await db;
    IsarCollection<SalaryModel> salaryCollection =
        isar.collection<SalaryModel>();

    return await salaryCollection.where().findAll();
  }

  Future<void> updateSalary(SalaryModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.salaryModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateSalary(val);
    }
  }

  Future<void> deleteSalary(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.salaryModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeSalary(val);
    }
  }

  // sync salaries
  Future<void> salariesSync() async {
    final isar = await db;
    IsarCollection<SalaryModel> salaryCollection =
        isar.collection<SalaryModel>();

    final salary = await salaryCollection.where().findAll();
    if (salary.isNotEmpty) {
      final res = await _supabaseHelper.getSalarys();
      if (res.length != salary.length) {
        if (salary.length >= res.length) {
          await Future.forEach(salary, (val) async {
            final res = await _supabaseHelper.getSalariesById(val.id!);
            if (res == false) {
              _supabaseHelper.addSalary(val.toJson());
            }
          });
          final res = await _supabaseHelper.getSalarys();
          insertSalaryFresh(res);
        } else {
          insertSalaryFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getSalarys();
      insertSalaryFresh(res);
    }
  }

  Future<void> clearSalary() async {
    final isar = await db;
    IsarCollection<SalaryModel> salaryCollection =
        isar.collection<SalaryModel>();
    isar.writeTxn<void>(() => salaryCollection.clear());
  }

  insertSalaryFresh(List<SalaryModel> salaryList) async {
    final isar = await db;
    await clearSalary();

    if (salaryList.isNotEmpty) {
      await Future.forEach(
          salaryList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.salaryModels.put(val)));
    }
  }

  // due payment
  // inventory
  Future<void> addDuePayment(DuePaymentModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.duePaymentModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addDuePayment(val.toJson());
    }
  }

  Future<void> deleteDuePayment(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.duePaymentModels.delete(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.removeDuePayment(val);
    }
  }

  Future<void> updateDuePayment(DuePaymentModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.duePaymentModels.put(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.updateDuePayment(val);
    }
  }

  Future<List<DuePaymentModel>> getDuePayments({String? value}) async {
    final isar = await db;
    IsarCollection<DuePaymentModel> duePaymentCollection =
        isar.collection<DuePaymentModel>();
    return await duePaymentCollection.where().findAll();
  }

  // sync due payment
  Future<void> duePaymentSync() async {
    final duePayments = await getDuePayments();
    if (duePayments.isNotEmpty) {
      final res = await _supabaseHelper.getDuePayment();
      if (res.length != duePayments.length) {
        if (duePayments.length >= res.length) {
          await Future.forEach(duePayments, (val) async {
            final res = await _supabaseHelper.getDuePaymentById(val.id!);
            if (res == false) {
              _supabaseHelper.addDuePayment(val.toJson());
            }
          });
          final res = await _supabaseHelper.getDuePayment();
          insertDuePaymentFresh(res);
        } else {
          insertDuePaymentFresh(res);
        }
      }
    } else {
      final res = await _supabaseHelper.getDuePayment();
      insertDuePaymentFresh(res);
    }
  }

  Future<void> clearDuePayment() async {
    final isar = await db;
    IsarCollection<DuePaymentModel> duePaymentCollection =
        isar.collection<DuePaymentModel>();
    isar.writeTxn<void>(() => duePaymentCollection.clear());
  }

  insertDuePaymentFresh(List<DuePaymentModel> duePaymentList) async {
    final isar = await db;
    await clearDuePayment();
    if (duePaymentList.isNotEmpty) {
      await Future.forEach(
          duePaymentList,
          (val) async =>
              await isar.writeTxn<int>(() => isar.duePaymentModels.put(val)));
    }
  }

  Future<void> createBackUp() async {
    final isar = await db;
    final backUpDir = await getDownloadsDirectory();

    final File backUpFile = File('${backUpDir?.path}/backup_db.isar');
    if (await backUpFile.exists()) {
      // if already we have another backup file, delete it here.
      await backUpFile.delete();
    }
    await isar.copyToFile('${backUpDir?.path}/backup_db.isar');
  }

  Future<void> restoreDB() async {
    final dbDirectory = await getApplicationDocumentsDirectory();
    final isar = await db;

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await isar.close(deleteFromDisk: true).then((_) async {
        File targetFile = await file.copy("${dbDirectory.path}/default.isar");
        log("Correctly copied to ${targetFile.path}");
        await Isar.open(
          [
            ItemModelSchema,
            CustomerModelSchema,
            PenjualanModelSchema,
            UserModelSchema,
            AuthModelSchema,
            StoreModelSchema,
            PresenceModelSchema,
            RentItemModelSchema,
            RentModelSchema,
            ExpensesModelSchema,
            SalaryModelSchema,
            DuePaymentModelSchema
          ],
          directory: dbDirectory.path,
        );
      });
    }
  }

  Future<void> clearAllData() async {
    final isar = await db;
    isar.writeTxn<void>(() => isar.clear());
    await isar.close(deleteFromDisk: true);
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          ItemModelSchema,
          CustomerModelSchema,
          PenjualanModelSchema,
          UserModelSchema,
          AuthModelSchema,
          StoreModelSchema,
          PresenceModelSchema,
          RentItemModelSchema,
          RentModelSchema,
          ExpensesModelSchema,
          SalaryModelSchema,
          DuePaymentModelSchema
        ],
        directory: dir.path,
        inspector: true,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }
}
