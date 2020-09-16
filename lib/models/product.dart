import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  // String id = Uuid().v1(); //<-- we can set it bcs it's be called in constructor
  String sku;
  String name;
  String qTy;
  String weight;
  String price = '0';
  String prodNote;
  String rate;
  String uriImg;
  String category;
  String tag;
  String promo;
  String desc;

  Product({
    this.sku,
    this.name,
    this.qTy,
    this.price,
    this.prodNote,
    this.weight,
    this.rate,
    this.uriImg,
    this.category,
    this.tag,
    this.promo,
    this.desc,
  });

  @override
  List<Object> get props => [
        sku,
        name,
        category,
        tag,
        qTy,
        price,
        prodNote,
        weight,
        rate,
        uriImg,
        promo,
        desc,
      ];

  @override
  String toString() {
    return 'model - Product {sku:$sku, name: $name,cat:$category, tag:$tag, qTy: $qTy, price: $price, prodNote: $prodNote, weight:$weight,rate:$rate, img:$uriImg, promotion:$promo, desc:$desc}';
  }

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'name': name,
      'qTy': qTy,
      'price': price,
      'prodNote': prodNote,
      'weight': weight,
      'rate': rate,
      'uriImg': uriImg,
      'category': category,
      'tag': tag,
      'promo': promo,
      'desc': desc,
    };
  }

  static Product fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    // Helper.debugLog('POJO - Product - Product', map);
    return Product(
      sku: map['sku'],
      name: map['name'],
      qTy: map['qTy'],
      price: map['price'],
      prodNote: map['prodNote'],
      weight: map['weight'],
      rate: map['rate'],
      uriImg: map['uriImg'],
      category: map['category'],
      tag: map['tag'],
      promo: map['promo'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  static Product fromJson(String source) => fromMap(json.decode(source));
  static Product fromSnapshot(DocumentSnapshot snap) {
    if (snap.data.length == 0) return null;

    return Product(
      sku: snap.data['sku'],
      name: snap.data['name'],
      qTy: snap.data['qTy'],
      price: snap.data['price'],
      prodNote: snap.data['prodNote'],
      weight: snap.data['weight'],
      rate: snap.data['rate'],
      uriImg: snap.data['uriImg'],
      category: snap.data['category'],
      tag: snap.data['tag'],
      promo: snap.data['promo'],
      desc: snap.data['desc'],
    );
  }
}
