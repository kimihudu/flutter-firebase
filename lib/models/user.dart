import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/models.dart';
import 'order.dart';

@immutable
class User extends Equatable {
  String phone;
  String name;
  String email;
  String addr;
  String total;
  String paid;
  String payment;
  String cusNote;
  String img;
  bool verified;

  // List<Order> orders;
  // List<Product> wishList;

  User({
    this.name,
    this.email,
    this.phone,
    this.total,
    this.paid,
    this.payment,
    this.addr,
    this.cusNote,
    this.img,
    this.verified,
  });

  @override
  // TODO: implement props
  List<Object> get props =>
      [phone, name, email, addr, total, paid, payment, cusNote, img, verified];

  @override
  String toString() =>
      'model - User {phoneNo: $phone, name: $name,email: $email, addr: $addr, totals: $total, paid:$paid, payment:$payment, cusNote:$cusNote, img:$img, verified:$verified}';

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "addr": addr,
      "total": total,
      "payment": payment,
      "paid": paid,
      "cusNote": cusNote,
      "img": img,
      "verified": verified,
    };
    // "orders": orders.map((e) => e.toMap()).toList(),
    //   "wishList": wishList.map((e) => e.toMap()).toList(),
  }

  static User fromMap(Map<String, dynamic> source) {
    if (source == null) return null;

    final _orders =
        source['orders'].map<Order>((order) => Order.fromMap(order)).toList();
    final _wishList = source['wishList']
        .map<Product>((prod) => Product.fromMap(prod))
        .toList();

    return User(
      phone: source["phone"],
      email: source["email"],
      name: source["name"],
      addr: source["addr"],
      total: source["total"],
      paid: source["paid"],
      payment: source["payment"],
      cusNote: source["cusNote"],
      img: source["img"],
      verified: source["verified"],
    );
  }

  String toJson() => json.encode(toMap());

  ///if this fromJson input is String
  ///need to add json decode
  static User fromJson(String source) => fromMap(json.decode(source));
  static User fromSnapshot(DocumentSnapshot snap) {
    if (snap.data.length == 0) return null;

    return User(
      phone: snap.data["phone"],
      email: snap.data["email"],
      name: snap.data["name"],
      addr: snap.data["addr"],
      total: snap.data["total"],
      paid: snap.data["paid"],
      payment: snap.data["payment"],
      cusNote: snap.data["cusNote"],
      img: snap.data["img"],
      verified: snap.data["verified"],
    );
  }
}
