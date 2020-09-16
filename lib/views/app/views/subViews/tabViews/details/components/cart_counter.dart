import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grocery_app/constants/enum.dart';
import 'package:grocery_app/helper/ultis.dart';

class CartCounter extends StatefulWidget {
  final OnChangeCallBack onChange;
  final String numItem;

  const CartCounter({Key key, this.onChange, this.numItem}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.numItem == null
        ? numOfItems = 1
        : numOfItems = int.parse(widget.numItem);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
                /**
                 * when create a callback func, keep it in setState.
                 * So in the output, the other widget could call setState when this func change
                */
                widget.onChange(numOfItems);
                Helper.debugLog('cart_counter -', numOfItems);
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
                /**
                 * when create a callback func, keep it in setState.
                 * So in the output, the other widget could call setState when this func change
                */
                widget.onChange(numOfItems);
                Helper.debugLog('cart_counter +', numOfItems);
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
