import 'package:flutter/material.dart';

import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/widgets/app_widgets/app_bar_wg.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.green, //Color.fromRGBO(157, 191, 142, 1),
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }
}
