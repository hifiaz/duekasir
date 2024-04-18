import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/model/pembeli_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  late Future<Isar> db;

  Database() {
    db = openDB();
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
    // IsarCollection<Contact> contacts = isar.contacts;
    IsarCollection<UserModel> userCollection = isar.collection<UserModel>();
    final users = userCollection.where().findAll();
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

  Future<void> addInventory(ItemModel val) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.itemModels.putSync(val));
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

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          ItemModelSchema,
          PembeliModelSchema,
          PenjualanModelSchema,
          UserModelSchema
        ],
        directory: dir.path,
        inspector: true,
      );

      return isar;
    }

    return Future.value(Isar.getInstance());
  }
}
