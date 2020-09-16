import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/auth/bloc.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'cart_bloc_wg.dart';

Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.green,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: <Widget>[
      IconButton(
        color: Colors.white,
        icon: WebsafeSvg.asset("assets/icons/search.svg"),
        onPressed: () {},
      ),
      IconButton(
        icon: cartWg(),
        onPressed: () => Navigator.pushNamed(context, MainAppViewRoute,
            arguments: {'index': 2, 'data': null}),
      ),
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          String _route = "";
          bool _oauth;
          if (state is AuthenticationSuccess) {
            _route = MyAccRoute;
            _oauth = true;
          } else {
            _route = LoginRoute;
            _oauth = false;
          }
          return IconButton(
            icon: Icon(
              Icons.account_circle,
              color: _oauth ? Colors.yellow : Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, _route),
          );
        },
      ),
      SizedBox(width: 20 / 2)
    ],
  );
}
