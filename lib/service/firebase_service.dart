import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference inventory = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('inventory');

  Future getInventoryAll() async {
    List data = [];
    List<ItemModel> allInventory = [];

    await inventory.orderBy('id', descending: false).get().then((QuerySnapshot value) {
      for (var element in value.docs) {
        data.add(element.data());
      }
    });

    for (var document in data) {
      allInventory.add(ItemModel.fromJson(document));
    }

    return allInventory;
  }

  addInventory(Map data) async {
    await inventory.add(data).then((value) {
      log('success add inventory $value');
    }).catchError((error) {
      log('error add inventory $error');
    });
  }

  removeInventory(int id) async {
    await inventory.where("id", isEqualTo: id).get().then((value) async {
      DocumentSnapshot doc = value.docs.first;
      await inventory.doc(doc.id).delete();
    });
  }

  updateInventory(ItemModel item) async {
    await inventory.where("id", isEqualTo: item.id).get().then((value) async {
      if (value.docs.isEmpty) {
        addInventory(item.toJson());
      } else {
        DocumentSnapshot doc = value.docs.first;
        await inventory.doc(doc.id).update(item.toJson());
      }
    });
  }
}
