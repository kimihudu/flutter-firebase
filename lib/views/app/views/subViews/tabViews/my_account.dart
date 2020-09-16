import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';

class AccountView extends StatefulWidget {
  AccountView({Key key}) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool editMode = false;
  TextEditingController 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: _mainView(),
    );
  }

  Widget _mainView() {
    return Builder(
      builder: (context) {
        return Container(
          child: Stack(
            children: <Widget>[
              _heroSec(),
              Container(
                child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                margin: EdgeInsets.only(top: 72, left: 24),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 20,
                  ),
                  Expanded(
                    child: _userProfileSec(),
                    flex: 75,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 05,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _userProfileSec() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      User user;
      if (state is AuthenticationSuccess) {
        user = state.user;
      } else {
        Helper.debugLog('my_account > _userProfileSec > user', 'null');
        return Center(
            child: Container(
          child: RaisedButton(
            onPressed: () => Navigator.pushNamed(context, LoginRoute,
                arguments: {'from': MyAccRoute, 'next': LoginRoute}),
            child: Text('Login'),
          ),
        ));
      }
      return Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Card(
                margin: EdgeInsets.only(top: 50, left: 16, right: 16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // IconButton(
                          //   icon: Icon(Icons.settings),
                          //   iconSize: 24,
                          //   color: Colors.black,
                          //   onPressed: () {},
                          // ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                            iconSize: 24,
                            onPressed: () {
                              setState(() {
                                editMode = true;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: editMode
                          ? Text(
                              "${user.name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            )
                          : TextField(controller: ,),
                    ),
                    Text(
                      "${user.email}",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    _listSections()
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/default-avatar.jpg"),
                        fit: BoxFit.contain)),
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _heroSec() {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: 200,
              height: 200,
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            ),
            top: -40,
            left: -40,
          ),
          Positioned(
            child: Container(
              width: 300,
              height: 260,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.5), shape: BoxShape.circle),
            ),
            top: -40,
            left: -40,
          ),
          Positioned(
            child: Align(
              child: Container(
                width: 400,
                height: 260,
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    shape: BoxShape.circle),
              ),
            ),
            top: -40,
            left: -40,
          ),
        ],
      ),
    );
  }

  Widget _listSections() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        _section(
            title: 'History',
            icon: Icon(Icons.history),
            callback: () => Navigator.pushNamed(context, 'history')),
        _section(
            title: 'Wishlist',
            icon: Icon(Icons.list),
            callback: () => Navigator.pushNamed(context, 'wishlist')),
        _section(
            title: 'Address',
            icon: Icon(Icons.polymer_rounded),
            callback: () => Navigator.pushNamed(context, 'Address')),
        _section(
            title: 'Payment',
            icon: Icon(Icons.credit_card),
            callback: () => Navigator.pushNamed(context, 'Payment')),
        _section(
            title: 'Logout',
            icon: Icon(Icons.logout),
            callback: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());

              showOverlay(context, '', 2);
              Future.delayed(Duration(seconds: 2), () {
                Navigator.pushNamed(context, MainAppViewRoute,
                    arguments: {'index': 0, 'data': null});
              });
            }),
      ],
    );
  }

  Widget _section({String title, Icon icon, Function callback}) {
    return Builder(
      builder: (context) {
        return InkWell(
          splashColor: Colors.teal.shade200,
          onTap: callback,
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 12),
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 30,
                  child: icon,
                ),
                // Image(
                //   image: Icon,
                //   width: 20,
                //   height: 20,
                //   color: Colors.grey.shade500,
                // ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                Spacer(
                  flex: 1,
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
