import 'package:flutter/material.dart';
import 'package:grocery_app/constants/enum.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatefulWidget {
  final OnChangeCallBack onChange;
  const CounterWithFavBtn({Key key, this.onChange}) : super(key: key);

  @override
  _CounterWithFavBtnState createState() => _CounterWithFavBtnState();
}

class _CounterWithFavBtnState extends State<CounterWithFavBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(onChange: (value) {
          widget.onChange(value);
          // Helper.debugLog('counter_with_fav_btn > CartCounter change', value);
        }),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: WebsafeSvg.asset("assets/icons/heart.svg"),
        )
      ],
    );
  }
}
