import 'package:flutter/material.dart';
import 'package:grocery_app/models/models.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              // decoration: BoxDecoration(
              //   color: Colors.green.withOpacity(0.3),
              //   borderRadius: BorderRadius.circular(17),
              // ),
              child: Hero(
                tag: "${product.sku}",
                child: Image.network(product.uriImg),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              // products is out demo list
              product.name,
              style: TextStyle(color: Color(0xFF3D82AE)),
            ),
          ),
          Text(
            "\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
