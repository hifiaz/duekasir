import 'dart:developer';
import 'dart:io';

import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/firebase_service.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  late Future<Isar> db;

  Database() {
    db = openDB();
  }

  final CloudFirestoreHelper _cloudFirestoreHelper = CloudFirestoreHelper();

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
  }

  Future<void> deleteUser(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.userModels.delete(val));
  }

  Future<void> updateUser(UserModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() => isar.userModels.put(val));
  }

  Future<List<UserModel>> getUsers() async {
    final isar = await db;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    final users = userCollection.where().findAll();
    return users;
  }

  Future<UserModel?> getUserById(int id) async {
    final isar = await db;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    final users = userCollection.get(id);
    return users;
  }

  // Customer
  Future<void> addNewCustomer(CustomerModel val) async {
    val.isSynced = isDeviceConnected.value;
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.customerModels.putSync(val));
    if (isDeviceConnected.value) {
      _cloudFirestoreHelper.addCustomer(val.toJson());
    }
  }

  Future<void> deleteCustomer(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.customerModels.delete(val));
    if (isDeviceConnected.value) {
      _cloudFirestoreHelper.removeCustomer(val);
    }
  }

  Future<void> updateCustomer(CustomerModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.customerModels.put(val));
    if (isDeviceConnected.value) {
      _cloudFirestoreHelper.updateCustomer(val);
    }
  }

  Future<List<CustomerModel>> getCustomers() async {
    final isar = await db;
    IsarCollection<CustomerModel> customerCollection =
        isar.collection<CustomerModel>();
    final customer = customerCollection.where().findAll();
    return customer;
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
      _cloudFirestoreHelper.addInventory(val.toJson());
    }
  }

  Future<void> addAllInventory(List<ItemModel> vals) async {
    final isar = await db;
    for (var val in vals) {
      val.isSynced = isDeviceConnected.value;
      isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
      if (isDeviceConnected.value) {
        _cloudFirestoreHelper.addInventory(val.toJson());
      }
    }
  }

  Future<void> deleteInventory(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.itemModels.delete(val));
    if (isDeviceConnected.value) {
      _cloudFirestoreHelper.removeInventory(val);
    }
  }

  Future<void> updateInventory(ItemModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.itemModels.put(val));
    if (isDeviceConnected.value) {
      _cloudFirestoreHelper.updateInventory(val);
    }
  }

  Future<void> getInventorys() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    if (isDeviceConnected.value) {
      inventoryController.inventorys.value =
          await _cloudFirestoreHelper.getInventoryAll();

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
          _cloudFirestoreHelper.removeInventory(element.id!);
        }
        inventoryController.deleteItemList.value.clear();
      }
      if (unsyncedInventory.isNotEmpty) {
        for (ItemModel element in unsyncedInventory) {
          element.isSynced = true;
          await _cloudFirestoreHelper.updateInventory(element);
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

  // sales
  Future<void> addPenjualan(PenjualanModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.penjualanModels.putSync(val));
  }

  Future<void> removePenjualan(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() => isar.penjualanModels.delete(val));
  }

  Future<List<PenjualanModel>> getPenjualan() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    final items = inventoryCollection.where().findAll();
    return items;
  }

  Future<List<PenjualanModel>> getReportToday() async {
    final isar = await db;
    IsarCollection<PenjualanModel> inventoryCollection =
        isar.collection<PenjualanModel>();
    final items = inventoryCollection
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
    final items = inventoryCollection
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

  Future<void> addStore(StoreModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.storeModels.putSync(val));
  }

  Future<void> updateStore(StoreModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.storeModels.put(val));
  }

  Future<StoreModel?> getStore() async {
    final isar = await db;
    IsarCollection<StoreModel> storeCollection = isar.collection<StoreModel>();
    final store = storeCollection.get(1);
    return store;
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
          StoreModelSchema
        ],
        directory: dir.path,
        inspector: true,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }
}
