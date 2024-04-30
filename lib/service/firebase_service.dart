import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreHelper {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference inventory = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('inventory');

  static final CollectionReference customer = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('customer');

  Future getInventoryAll() async {
    List data = [];
    List<ItemModel> allInventory = [];

    await inventory
        .orderBy('id', descending: false)
        .get()
        .then((QuerySnapshot value) {
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

  // customer
  Future getCustomerAll() async {
    List data = [];
    List<CustomerModel> allCustomer = [];

    await customer
        .orderBy('id', descending: false)
        .get()
        .then((QuerySnapshot value) {
      for (var element in value.docs) {
        data.add(element.data());
      }
    });

    for (var document in data) {
      allCustomer.add(CustomerModel.fromJson(document));
    }

    return allCustomer;
  }

  addCustomer(Map data) async {
    await customer.add(data).then((value) {
      log('success add customer $value');
    }).catchError((error) {
      log('error add customer $error');
    });
  }

  removeCustomer(int id) async {
    await customer.where("id", isEqualTo: id).get().then((value) async {
      DocumentSnapshot doc = value.docs.first;
      await customer.doc(doc.id).delete();
    });
  }

  updateCustomer(ItemModel item) async {
    await customer.where("id", isEqualTo: item.id).get().then((value) async {
      if (value.docs.isEmpty) {
        addCustomer(item.toJson());
      } else {
        DocumentSnapshot doc = value.docs.first;
        await customer.doc(doc.id).update(item.toJson());
      }
    });
  }
}
