import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/helper/responsive.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/dummy/prods.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/widgets/app_widgets/app_bar_wg.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';
import 'package:location/location.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<Product> cartProds = List();
  Order cartOrder = Order();
  String shipAddr = '123 Your address';
  String deliverTime = '30 min.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _shippingAddr(),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            _deliveryOpt(),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            _paymentOpt(),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            _blocData(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _shippingAddr() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          User _user = state.user;
          shipAddr = _user.addr;
        }

        return _baseListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.green[700],
          ),
          title: 'Deliver to',
          subtitle: shipAddr,
          trailing: GestureDetector(
            child: Text(
              'Change',
              style: TextStyle(
                color: Colors.green[700],
                fontSize: 12,
              ),
            ),
            onTap: () {
              _shipAddrDialog().then((value) {
                setState(() {
                  shipAddr = value;
                });
              });
            },
          ),
        );
      },
    );
  }

  Future<String> _shipAddrDialog() {
    var _txtInputController = TextEditingController();

    var _btnSize = AppSetting.settingBtnNoSC(context)['btnSize'];
    var _fontSize = AppSetting.settingBtnNoSC(context)['fontSize'] + 5;
    var _gap = AppSetting.settingBtnNoSC(context)['margin'];

    Widget okButton = Container(
      margin: EdgeInsets.only(right: _gap),
      height: _btnSize,
      width: _btnSize * 2,
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.greenAccent),
        shape: StadiumBorder(),
        padding: EdgeInsets.all(5.0),
        child: Text('Save', style: TextStyle(color: Colors.black45)),
        onPressed: () {
          var _callback = _txtInputController.text;

          Navigator.of(context, rootNavigator: true).pop(_callback);

          Helper.debugLog('_shipAddrDialog > callback', _callback);
        },
      ),
    );

    Widget cancelButton = Container(
      margin: EdgeInsets.only(right: 10),
      height: _btnSize,
      width: _btnSize * 2,
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.greenAccent),
        shape: StadiumBorder(),
        padding: EdgeInsets.all(5.0),
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black45),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pop(); //<-- need rootNavigator true for go back corrext context
        },
      ),
    );
    Widget txtText = Container(
        width: Responsive(context).rW(0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('Change Address'),
            Container(
              height: Responsive(context).rH(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: InputDecoration(icon: Icon(Icons.place)),
                    style: TextStyle(fontSize: _fontSize),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    controller: _txtInputController,
                  ),
                ),
                VerticalDivider(
                  width: 10,
                ),
              ],
            )
          ],
        ));
    Widget title = Center(
      child: Text(
        'Shipping Address',
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Helper.baseDialog(context, [okButton, cancelButton], title, txtText);
  }

  Widget _deliveryOpt() {
    return _baseListTile(
      leading: Icon(
        Icons.access_time,
        color: Colors.green[700],
      ),
      title: 'Delivery Time',
      subtitle: "$deliverTime min.",
      trailing: GestureDetector(
        child: Text(
          'Change',
          style: TextStyle(
            color: Colors.green[700],
            fontSize: 12,
          ),
        ),
        onTap: () async {
          Duration resultingDuration = await showDurationPicker(
            context: context,
            initialTime: new Duration(minutes: 30),
          );
          setState(() {
            deliverTime = resultingDuration.inMinutes.toString();
          });
        },
      ),
    );
  }

  Widget _paymentOpt() {
    return _baseListTile(
      leading: Icon(
        Icons.credit_card,
        color: Colors.green[700],
      ),
      title: 'Payment',
      subtitle: "COD",
      trailing: GestureDetector(
        child: Text(
          'Change',
          style: TextStyle(
            color: Colors.green[700],
            fontSize: 12,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _blocData() {
    return BlocBuilder<CartBloc, CartStates>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: loadingProgress,
          );
        } else if (state is CartLoaded) {
          List<Product> _data = state.items;
          cartProds = _data;
          return _cusOrder(_data);
        }
        return Container(
          child: Text('Something Wrong'),
        );
      },
    );
  }

  Widget _cusOrder(List<Product> _data) {
    /**
     * test data
     * List<Product> _data = tmpData.map((e) => Product.fromMap(e)).toList();
    */
    String subTotal = Helper.cartTotal(_data);
    String shipFee = 'Free';
    String total = shipFee == 'Free'
        ? subTotal
        : double.parse(subTotal) + double.parse(shipFee);
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Your Order',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    'Add More Product',
                    style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.pushNamed(context, MainAppViewRoute,
                      arguments: {'index': 0, 'data': null}),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          ..._data.map((prod) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(
                        prod.uriImg,
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.green[50],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Text(
                          prod.qTy,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          prod.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        // ...order.orderAddOns.map(
                        //   (addOn) {
                        //     return Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(vertical: 1.0),
                        //       child: Text(
                        //         "${addOn.name} (\$${addOn.price.toStringAsFixed(2)})",
                        //         style: TextStyle(
                        //           fontSize: 11,
                        //           color: Colors.black54,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ).toList(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$${prod.price}",
                      style: TextStyle(
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Divider(
              height: 1,
              color: Colors.black26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "$subTotal",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 6.0,
              bottom: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Delivery Fee',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "$shipFee",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Divider(
              height: 1,
              color: Colors.black26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 10.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$total",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _baseListTile(
      {String title, String subtitle, Widget leading, Widget trailing}) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: leading,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: trailing,
          )
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    bool _oauth = false;
    User _currentUser;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        _oauth = state is AuthenticationSuccess ? true : false;
        if (state is AuthenticationSuccess) {
          _oauth = true;
          _currentUser = state.user;
        }
        return BottomAppBar(
          color: Colors.grey[100],
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24,
            ),
            child: FlatButton(
                padding: EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Colors.green[700],
                child: Text(
                  'Place Order'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  if (_oauth) {
                    Navigator.pushNamed(context, ConfirmRoute);
                    cartOrder.cusEmail = _currentUser.email;
                    cartOrder.cusPhone = _currentUser.phone;
                    cartOrder.cusPhone = _currentUser.phone;
                    cartOrder.cusName = _currentUser.name;
                    cartOrder.products = cartProds;
                    cartOrder.shipAddr = shipAddr;
                    cartOrder.status = 'Pending';
                    cartOrder.date = Helper.getCurrentDate('mdE');
                    BlocProvider.of<CartBloc>(context)
                      ..add(PlaceOrder(order: cartOrder));
                  } else {
                    Helper.oopAlert(context, 'Oop!',
                        'Please login before placing your order.');
                  }
                  ;
                }),
          ),
        );
      },
    );
  }
}
