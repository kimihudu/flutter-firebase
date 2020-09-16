import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/simple_bloc_delegate.dart';
import 'package:grocery_app/views/layout_template/layout_template.dart';

import 'constants/setting.dart';
import 'helper/ultis.dart';
import 'locator.dart';

void main() {
  setupLocator();
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weed Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      home: LayoutTemplate(),
    );
  }
}
