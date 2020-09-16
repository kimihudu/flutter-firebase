import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';

class AddToCart extends StatelessWidget {
  final int amount;
  const AddToCart({
    Key key,
    @required this.product,
    this.amount,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartStates>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: loadingProgress,
          );
        } else if (state is CartLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 50,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Color(0xFF3D82AE),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                        ..add(CartItemAdded(
                          item: product,
                          quantity: amount,
                        ));
                      Helper.debugLog(
                          'add_to_Cart > add_shopping_cart > CartItemAdded',
                          {'item': product, 'amount': amount});
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: Color(0xFF3D82AE),
                      onPressed: () {
                        //add cadrt
                        //nav to checkout
                        BlocProvider.of<CartBloc>(context)
                          ..add(CartItemAdded(
                            item: product,
                            quantity: amount,
                          ));
                        Navigator.pushNamed(context, CheckOutRoute);
                        Helper.debugLog(
                            'add_to_Cart > add_shopping_cart > CartItemAdded > nav to CheckOutRoute',
                            {'item': product, 'amount': amount});
                      },
                      child: Text(
                        "Buy  Now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          child: Text('Something Wrong'),
        );
      },
    );
  }
}
