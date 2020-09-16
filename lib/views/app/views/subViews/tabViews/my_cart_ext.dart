import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/repo/dummy/prods.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/app/views/subViews/tabViews/details/components/cart_counter.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'details/prod_details.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _branding(),
              _headlineListItem(),
              _listItem(),
              _headlineSuggestion(),
              _suggestionList()
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      title: Text(
        'My Cart',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: WebsafeSvg.asset("assets/icons/back.svg"),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: WebsafeSvg.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, MyAccRoute),
        ),
        SizedBox(width: 20 / 2)
      ],
    );
  }

  Widget _bottomNavBar() {
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
            'CheckOut'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, CheckOutRoute),
        ),
      ),
    );
  }

  Widget _branding() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.restaurant,
            color: Colors.green[700],
          ),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          Text(
            'FarmersLink',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headlineListItem() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20.0,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Your Order',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          // GestureDetector(
          //   child: Text(
          //     'Add item',
          //     style: TextStyle(
          //       color: Colors.green[700],
          //     ),
          //   ),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget _listItem() {
    /**
     * Test data
     * List<Product> _data = tmpData.map((e) => Product.fromMap(e)).toList();
    */

    return BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
      if (state is CartLoading) {
        return Center(
          child: loadingProgress,
        );
      } else if (state is CartLoaded) {
        List<Product> _listProds = state.items;
        List _data = List();
        var _indexListGroup = Helper.getIndexListGroup(_listProds, 'sku');
        _indexListGroup.forEach((el) {
          var elVsQty = Helper.countElementInGroup(
              _indexListGroup, _indexListGroup.indexOf(el));
          _data.add(elVsQty);
        });
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: _data.map((map) {
              Product prod = map['item'];
              String prodCount = map['count'].toString();
              return ListTile(
                leading: _heroImg(prod),
                title: _nameVsPrice(prod),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       'X$prodCount',
                    //       style: TextStyle(fontSize: 11),
                    //     )
                    //   ],
                    // ),
                    // _counter(prodCount),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: CartCounter(
                        onChange: (value) {
                          BlocProvider.of<CartBloc>(context)
                            ..add(CartItemEdited(item: prod, quantity: value));

                          Helper.debugLog(
                              'my_Cart_ext > CartBloc > prod-${prod.sku} quantity change',
                              value);
                        },
                        numItem: prodCount,
                      ),
                    )
                  ],
                ),
                isThreeLine: true,
              );
            }).toList(),
          ),
        );
      }
      return Container(child: Text('Something wrong'));
    });
  }

  Widget _nameVsPrice(Product prod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          prod.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          "\$${prod.price}",
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  Widget _heroImg(Product prod) {
    return AspectRatio(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                product: prod,
              ),
            )),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Hero(tag: prod.sku, child: Image.network(prod.uriImg)),
        ),
      ),
      aspectRatio: 1,
    );
  }

  Widget _headlineSuggestion() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20.0,
        bottom: 8,
      ),
      child: Text(
        'Maybe you would like these?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _suggestionList() {
    List<Product> _data = tmpData.map((e) => Product.fromMap(e)).toList();
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: _data.map((prod) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          prod.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          "\$${prod.price}",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                  Image.network(prod.uriImg)
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
