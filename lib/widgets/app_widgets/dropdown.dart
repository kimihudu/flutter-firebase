import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enum.dart';
import 'package:grocery_app/constants/setting.dart';

// typedef CallbackAction = Function(dynamic callBack);

class DropDownLucky extends StatefulWidget {
  final List<dynamic> listData;
  final OnChangeCallBack onChanged;
  final String selectedValue;
  final double size;
  final bool disable;
  DropDownLucky({
    Key key,
    this.listData,
    this.onChanged,
    this.size,
    this.selectedValue,
    this.disable,
  }) : super(key: key);

  @override
  _DropDownLuckyState createState() => _DropDownLuckyState();
}

class _DropDownLuckyState extends State<DropDownLucky> {
  String dropdownValue = '';
  List<dynamic> _listData = List();
  double _size;
  bool _disable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.selectedValue == null
        ? widget.listData[0]
        : widget.selectedValue;
    _listData = widget.listData;
    _size = widget.size;
    _disable = widget.disable == null ? false : widget.disable;
  }

  @override
  Widget build(BuildContext context) {
    widget.onChanged(dropdownValue);
    return DropdownButton<dynamic>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: _size == null ? 32 : _size,
      elevation: 16,
      style: TextStyle(
        color: _disable ? Colors.black38 : Colors.deepPurple,
      ),
      underline: Container(
        height: 3,
        color: _disable ? Colors.black38 : Colors.redAccent,
      ),
      onChanged: (val) =>
          _disable ? false : setState(() => this.dropdownValue = val),
      items: _listData.map<DropdownMenuItem<dynamic>>((dynamic value) {
        return DropdownMenuItem<dynamic>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: _size == null ? 32 : _size),
          ),
        );
      }).toList(),
    );
  }
}
