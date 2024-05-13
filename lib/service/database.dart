import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/expenses_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/presence_model.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/model/rent_model.dart';
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

  Future<List<UserModel>> getUsers() async {
    final isar = await db;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    if (isDeviceConnected.value) {
      final users = await _supabaseHelper.getUsers();
      if (users.isEmpty) {
        final users = userCollection.where().findAll();
        return users;
      }
      return users;
    } else {
      final users = userCollection.where().findAll();
      return users;
    }
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

  Future<List<CustomerModel>> getCustomers() async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    final customer = customerCollection.where().findAll();

    return customer;
  }

  Future<void> syncCustomers() async {
    final customers = await getCustomers();
    if (customers.isNotEmpty) {
      for (CustomerModel element in customers) {
        final res = await _supabaseHelper.getCustomerById(element.id!);
        if (res == false) {
          _supabaseHelper.addCustomer(element.toJson());
        }
      }
    } else {
      final res = await _supabaseHelper.getCustomerAll();
      if (res.isNotEmpty) {
        insertCustomerFresh(res);
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
      await getCustomers();
    }
  }

  Future<void> checkCustomerSynced() async {
    final users = await getUsers();
    if (users.isNotEmpty) {
      for (UserModel element in users) {
        final res = await _supabaseHelper.getReportById(element.id!);
        if (res == false) {
          // _supabaseHelper.addReport(element.toJson());
        }
      }
    } else {
      getReport();
    }
  }

  Future<List<CustomerModel>> searchCustomers({String? value}) async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    final items = customerCollection
        .filter()
        .group((q) => q.namaContains(value ?? '', caseSensitive: false))
        .findAll();
    return items;
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

  Future<void> getInventorys() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    if (isDeviceConnected.value) {
      inventoryController.inventorys.value =
          await _supabaseHelper.getInventoryAll();
      insertInventoryFresh(inventoryController.inventorys.value);
    } else {
      inventoryController.inventorys.value =
          await inventoryCollection.where().findAll();
    }
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
        for (ItemModel element in inventoryController.deleteItemList.value) {
          _supabaseHelper.removeInventory(element.id!);
        }
        inventoryController.deleteItemList.value.clear();
      }
      if (unsyncedInventory.isNotEmpty) {
        for (ItemModel element in unsyncedInventory) {
          element.isSynced = true;
          await _supabaseHelper.updateInventory(element);
          updateInventorySync(element);
        }
      }
    } else {
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

  Future<List<PenjualanModel>> getReport() async {
    final isar = await db;
    IsarCollection<PenjualanModel> reportCollection =
        isar.collection<PenjualanModel>();
    if (isDeviceConnected.value) {
      final List<PenjualanModel> res = await _supabaseHelper.getRepots();
      final items = await reportCollection.where().findAll();
      if (res.length == items.length || items.length >= res.length) {
        return items;
      } else {
        await insertReportFresh(res);
        final freshItems = await reportCollection.where().findAll();
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

  Future<Map<DateTime, List<PenjualanModel>>> getSalesByMonth() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    List<PenjualanModel> items = inventoryCollection
        .where()
        .filter()
        .createdAtBetween(
            DateTime.now()
                .subtract(const Duration(days: 30))
                .copyWith(hour: 0, minute: 0, second: 0),
            DateTime.now().copyWith(hour: 23, minute: 59, second: 59))
        .findAllSync();

    final Map<DateTime, List<PenjualanModel>> listOfOrders = items.groupListsBy(
        (order) => DateTime(
            order.createdAt.year, order.createdAt.month, order.createdAt.day));

    return listOfOrders;
  }

  Future<void> checkIsReportSynced() async {
    final reports = await getReport();
    if (reports.isNotEmpty) {
      for (PenjualanModel element in reports) {
        final res = await _supabaseHelper.getReportById(element.id!);
        if (res == false) {
          _supabaseHelper.addReport(element.toJson());
        }
      }
    } else {
      getReport();
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
    if (isDeviceConnected.value) {
      final res = await _supabaseHelper.getStore();
      if (res == null) {
        final store = storeCollection.where().findFirst();
        return store;
      }
      return res;
    } else {
      final store = storeCollection.where().findFirst();
      return store;
    }
  }

  Future<void> syncStore() async {
    final store = await getStore();
    if (store != null) {
      _supabaseHelper.updateStore(store);
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

  Future<List<PresenceModel>> getPresense() async {
    final isar = await db;
    IsarCollection<PresenceModel> presenseCollection =
        isar.collection<PresenceModel>();
    if (isDeviceConnected.value) {
      final res = await _supabaseHelper.getPresense();

      return res;
    } else {
      return await presenseCollection.where().findAll();
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
    if (isDeviceConnected.value) {
      final res = await _supabaseHelper.getRentItems();

      return res;
    } else {
      return await rentItemCollection.where().findAll();
    }
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
    if (isDeviceConnected.value) {
      final res = await _supabaseHelper.getRent();

      return res;
    } else {
      return await rentCollection.where().findAll();
    }
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

  // expenses
  Future<void> addExpenses(ExpensesModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.expensesModels.putSync(val));
    if (isDeviceConnected.value) {
      _supabaseHelper.addExpenses(val.toJson());
    }
  }

  Future<List<ExpensesModel>> getExpenses() async {
    final isar = await db;
    IsarCollection<ExpensesModel> expensesCollection =
        isar.collection<ExpensesModel>();
    if (isDeviceConnected.value) {
      final res = await _supabaseHelper.getExpenses();

      return res;
    } else {
      return await expensesCollection.where().findAll();
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
            StoreModelSchema
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
        ],
        directory: dir.path,
        inspector: true,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }
}
