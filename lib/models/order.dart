import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'product.dart';

//TODO: data exmaple

class Order extends Equatable {
  String id;
  String date;
  String cusPhone;
  String cusEmail;
  String cusName;
  String shipAddr;
  String locID;
  String telno;
  String web;
  String orderNote;
  List<Product> products;
  String total;
  String status;

  Order(
      {this.id,
      this.date,
      this.cusPhone,
      this.cusEmail,
      this.products,
      this.total,
      this.status,
      this.orderNote,
      this.shipAddr,
      this.cusName,
      this.locID,
      this.telno,
      this.web});

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        cusPhone,
        cusEmail,
        products,
        total,
        status,
        orderNote,
        shipAddr,
        date,
        cusName,
        locID,
        telno,
        web
      ];

  @override
  String toString() =>
      'model - Order {id: $id, date:$date, cusName: $cusPhone, cusPhone: $cusName, cusEmail: $cusEmail, products: $products, total: $total, status: $status, orderNote: $orderNote, shipping addr: $shipAddr, locID:$locID, telno:$telno, web:$web}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'cusPhone': cusPhone,
      'cusEmail': cusEmail,
      'cusName': cusName,
      'products': products.map((e) => e.toMap()).toList(), //
      'total': total,
      'status': status,
      'orderNote': orderNote,
      'shipAddr': shipAddr,
      'locID': locID,
      'telno': telno,
      'web': web,
    };
  }

  static Order fromMap(Map<dynamic, dynamic> source) {
    if (source == null) return null;

    final _products = source['products']
        .map<Product>((prod) => Product.fromMap(prod))
        .toList();

    return Order(
      id: source["id"],
      date: source["date"],
      cusPhone: source['cusPhone'],
      cusEmail: source['cusEmail'],
      cusName: source['cusName'],
      products: _products,
      total: source['total'],
      status: source['status'],
      orderNote: source['orderNote'],
      shipAddr: source['shipAddr'],
      locID: source['locID'],
      telno: source['telno'],
      web: source['web'],
    );
  }

  String toJson() => json.encode(toMap());

  static Order fromJson(String source) => fromMap(json.decode(source));

  static Order fromSnapshot(DocumentSnapshot source) {
    if (source.data.length == 0) return null;

    final _products = source.data['products'].data
        .map((doc) => Product.fromSnapshot(doc))
        .toList();

    return Order(
      id: source.data["id"],
      date: source.data["date"],
      cusPhone: source.data['cusPhone'],
      cusEmail: source.data['cusEmail'],
      cusName: source.data['cusName'],
      products: _products,
      total: source.data['total'],
      status: source.data['status'],
      orderNote: source.data['orderNote'],
      shipAddr: source.data['shipAddr'],
      locID: source.data['locID'],
      telno: source.data['telno'],
      web: source.data['web'],
    );
  }
}
