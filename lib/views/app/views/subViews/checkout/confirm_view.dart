import 'package:flutter/material.dart';

class ConfirmView extends StatefulWidget {
  ConfirmView({Key key}) : super(key: key);

  @override
  _ConfirmViewState createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Thank you'),
      ),
    );
  }
}
