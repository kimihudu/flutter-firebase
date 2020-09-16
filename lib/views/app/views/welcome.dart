import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/user_repo.dart';
import 'package:grocery_app/routing/route_names.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  //* add delay time to auto move to next screen
  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 1), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushNamed(context, PreLoginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogStates>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            child: _branding(),
          ),
        );
      },
    );
  }

  Widget _branding() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text('Hello',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 170.0, 0.0, 0.0),
            child: Text('There',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
            child: Text('.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          )
        ],
      ),
    );
  }
}
