import 'package:flutter/material.dart';
import 'package:grocery_app/models/models.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int countItem = 1;
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 20,
                    right: 20,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: widget.product),
                      SizedBox(height: 20 / 2),
                      CounterWithFavBtn(
                        onChange: (value) {
                          setState(() {
                            countItem = value;
                          });
                        },
                      ),
                      SizedBox(height: 20 / 2),
                      AddToCart(
                        product: widget.product,
                        amount: countItem,
                      ),
                      SizedBox(height: 20 / 2),
                      Expanded(
                        child: Description(product: widget.product),
                      ),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
