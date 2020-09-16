import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:websafe_svg/websafe_svg.dart';

Widget cartWg() {
  return BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
    if (state is CartLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CartLoaded) {
      var _cartAmount = state.totalItems.toString();
      return Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, right: 1),
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(5.0),
            child: WebsafeSvg.asset("assets/icons/cart.svg"),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _cartAmount,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              padding: EdgeInsets.all(3.0),
            ),
          ),
        ],
      );
    }
    return Container(
      child: Text('something wrong'),
    );
  });
}
