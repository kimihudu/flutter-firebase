import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class NoDataPage extends StatefulWidget {
  final dynamic badge;

  const NoDataPage({Key key, this.badge}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NoDataPageState();
  }
}

class _NoDataPageState extends State<NoDataPage> {
  String msg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msg = widget.badge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar('Oop!'),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 7 / 8,
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    offset: new Offset(0.0, 2.0),
                    blurRadius: 25.0,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32))),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        '$msg',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(String header) {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: Text(
        '$header',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
