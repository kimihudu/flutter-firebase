import 'dart:convert';

import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogRepo {
  final prodCollection = Firestore.instance.collection('products');
  final orderCollection = Firestore.instance.collection('orders');

  Future<List<Product>> reqProds() async {
    List<Product> _list = List();
    var tmp = prodCollection.snapshots().map((_snapshot) {
      return _snapshot.documents
          .map((doc) => Product.fromSnapshot(doc))
          .toList();
    });
    _list = await tmp.first; //<-- get the first element in stream
    // Helper.debugLog('catalog_repo > prods', _list);
    return _list;
  }

  Future<String> addOrder(Order order) async {
    var _docRef = await orderCollection.add(order.toMap());
    _docRef.updateData({'timestamp': FieldValue.serverTimestamp()});
    return _docRef.documentID;
  }
}
