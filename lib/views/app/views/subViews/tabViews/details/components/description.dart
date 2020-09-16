import 'package:flutter/material.dart';
import 'package:grocery_app/models/models.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        product.desc,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
