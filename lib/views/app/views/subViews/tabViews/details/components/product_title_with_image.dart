import 'package:flutter/material.dart';
import 'package:grocery_app/models/models.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   "Aristocratic Hand Bag",
          //   style: TextStyle(color: Colors.white),
          // ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Hero(
                  tag: "${product.sku}",
                  child: ClipRRect(
                    child: Image.network(
                      product.uriImg,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
