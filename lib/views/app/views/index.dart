import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps/google_maps.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/app/views/subViews/sub_views.dart';
import 'package:grocery_app/views/app/views/subViews/tabViews/my_cart_ext.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'subViews/tabViews/store/store.dart';

class MainAppView extends StatefulWidget {
  MainAppView({Key key}) : super(key: key);

  @override
  _MainAppViewState createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _indexWidget = 0;
  var _data;

  @override
  Widget build(BuildContext context) {
    // _indexWidget = widget.indexView;
    // _data = widget.data;
    Map<String, dynamic> _bundle = ModalRoute.of(context).settings.arguments;
    _indexWidget = _bundle['index'];
    _data = _bundle['data'];

// _data != null
//           ? OrderDetail(badge: _data)
//           : NoDataPage(badge: 'No Order is selected.'),
//       _data != null
//           ? SmsPage(badge: _data)
//           : NoDataPage(badge: 'No Order is selected.'),
    List<Widget> _widgetList = [
      MyStore(),
      ProdsView(catName: _data),
      CartScreen(),
      AccountView(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetList[_indexWidget],
      //temporary off bottom bar
      bottomNavigationBar: _botAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _indexWidget = 2;
            Navigator.pushNamed(context, MainAppViewRoute,
                arguments: <String, dynamic>{
                  'index': _indexWidget,
                  'data': _data
                });
          });
        },
        child: _cartWg(),
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _botAppBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            __botAppBarItem(
                0,
                Icon(
                  Icons.store,
                  color: Colors.black45,
                ),
                Text('Home')),
            SizedBox(
              width: 30,
            ),
            __botAppBarItem(
                3,
                Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                Text('Account')),
          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget __botAppBarItem(int index, Icon icon, Text text) {
    return InkWell(
      onTap: () {
        setState(() {
          _indexWidget = index;
          Navigator.pushNamed(context, MainAppViewRoute,
              arguments: <String, dynamic>{
                'index': _indexWidget,
                'data': _data
              });
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[icon, text],
      ),
    );
  }

  // Widget _buildBottomBar(BuildContext context) {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     currentIndex: _indexWidget,
  //     onTap: (index) {
  //       setState(() {
  //         _indexWidget = index;

  //         //go to subview in MainAppView

  //         Navigator.pushNamed(context, MainAppViewRoute,
  //             arguments: <String, dynamic>{
  //               'index': _indexWidget,
  //               'data': _data
  //             });

  //         Helper.debugLog('index > _buildBottomBar > selected view >',
  //             AppSetting.routesIndex2Name[_indexWidget]);
  //       });
  //     },
  //     items: [
  //       BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.store,
  //             size: 30,
  //           ),
  //           title: Text('Store')),
  //       // BottomNavigationBarItem(
  //       //     icon: Icon(
  //       //       Icons.list,
  //       //     ),
  //       //     title: Text(AppSetting.PRODSTAB, style: TextStyle())),
  //       BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('')),
  //       BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.account_circle,
  //             size: 30,
  //           ),
  //           title: Text('Account')),
  //     ],
  //   );
  // }

  Widget _cartWg() {
    return BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
      if (state is CartLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CartLoaded) {
        var _cartAmount = state.totalItems.toString();
        return Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5, right: 1),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(5.0),
              child: WebsafeSvg.asset("assets/icons/cart.svg"),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _cartAmount,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(3.0),
              ),
            ),
          ],
        );
      }
      return Container(
        child: Text('something wrong'),
      );
    });
  }
}
