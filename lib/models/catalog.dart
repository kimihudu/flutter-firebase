import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'product.dart';

//TODO: data exmaple

class Catalog extends Equatable {
  String id;
  String name;
  String img;
  List<Product> products;

  Catalog({
    this.id,
    this.name,
    this.img,
    this.products,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        name,
        img,
        products,
      ];

  @override
  String toString() =>
      'model - Catalog {id: $id, products: $products, name: $name, img: $img}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': name,
      'cusPhone': img,
      'products': products.map((e) => e.toMap()).toList(), //
    };
  }

  static Catalog fromMap(Map<dynamic, dynamic> source) {
    if (source == null) return null;

    final _products = source['products']
        .map<Product>((prod) => Product.fromMap(prod))
        .toList();

    return Catalog(
      id: source["id"],
      name: source["name"],
      img: source['img'],
      products: _products,
    );
  }

  String toJson() => json.encode(toMap());

  static Catalog fromJson(String source) => fromMap(json.decode(source));
}
