import 'dart:io';

import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/pembeli_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  late Future<Isar> db;

  Database() {
    db = openDB();
  }

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

  Future<void> addNewCustomer(PembeliModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.pembeliModels.putSync(val));
  }

  Future<void> deleteCustomer(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.pembeliModels.delete(val));
  }

  Future<void> updateCustomer(PembeliModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.pembeliModels.put(val));
  }

  Future<List<PembeliModel>> getCustomers() async {
    final isar = await db;
    IsarCollection<PembeliModel> customerCollection =
        isar.collection<PembeliModel>();
    final customer = customerCollection.where().findAll();
    return customer;
  }

  Future<PembeliModel?> getCustomerById(int id) async {
    final isar = await db;
    IsarCollection<PembeliModel> customerCollection =
        isar.collection<PembeliModel>();
    final users = customerCollection.get(id);
    return users;
  }

  Future<void> addInventory(ItemModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
  }

  Future<void> addAllInventory(List<ItemModel> vals) async {
    final isar = await db;
    for (var val in vals) {
      isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
    }
  }

  Future<void> deleteInventory(int val) async {
    final isar = await db;
    isar.writeTxn<bool>(() async => await isar.itemModels.delete(val));
  }

  Future<void> updateInventory(ItemModel val) async {
    final isar = await db;
    isar.writeTxn<int>(() async => await isar.itemModels.put(val));
  }

  Future<List<ItemModel>> getInventorys() async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    final items = inventoryCollection.where().findAll();
    return items;
  }

  Future<List<ItemModel>> searchInventorys(String value) async {
    final isar = await db;
    IsarCollection<ItemModel> inventoryCollection =
        isar.collection<ItemModel>();
    final items = inventoryCollection
        .filter()
        .group((q) => q
            .namaContains(value, caseSensitive: false)
            .or()
            .codeContains(value, caseSensitive: false))
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
        print("Correctly copied to ${targetFile.path}");
        await Isar.open(
          [
            ItemModelSchema,
            PembeliModelSchema,
            PenjualanModelSchema,
            UserModelSchema,
            AuthModelSchema,
            StoreModelSchema
          ],
          directory: dbDirectory.path,
        );
      });
      // final dbDirectory = await getApplicationDocumentsDirectory();

      // // close the database before any changes
      // await isar.close();

      // final dbFile = file;
      // final dbPath = p.join(dbDirectory.path, 'default.isar');

      // if (await dbFile.exists()) {
      //   // here we overwrite the backup file on the database file
      //   await dbFile.copy(dbPath);
      // }
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
          PembeliModelSchema,
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
