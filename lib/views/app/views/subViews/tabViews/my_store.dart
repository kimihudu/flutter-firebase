import 'package:flutter/material.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/dummy/prods.dart';
import 'package:grocery_app/routing/route_names.dart';

class StoreView extends StatefulWidget {
  StoreView({Key key}) : super(key: key);

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Store',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            _seachBar(),
            _headlineCat,
            _buildCategoryList(),
            _headlineDeal,
            _buildDealList()
          ],
        ),
      ),
    );
  }

  Widget _headlineSearchBar = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: Text(
          'All Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'View All',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    ],
  );
  Widget _headlineDeal = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: Text(
          'Cannabis Deals',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'View All',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    ],
  );

  Widget _headlineCat = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: Text(
          'What do you like?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, top: 4),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            '',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    ],
  );

  Widget _seachBar() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.green),
      child: TextField(
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Item',
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black38)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    var items = AppSetting.CATEGORIES;
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      alignment: Alignment.centerLeft,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, MainAppViewRoute,
                  arguments: <String, dynamic>{
                    'index': 1,
                    'data': data['name']
                  }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(data['name']),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //     child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(data['name']),
                  //     // Icon(
                  //     //   Icons.keyboard_arrow_right,
                  //     //   size: 14,
                  //     // )
                  //   ],
                  // ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDealList() {
    var items = addItems();
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  child: Image.network(data.uriImg),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4, left: 4),
                  width: 120,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$${data.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]);
        },
      ),
    );
  }

  List<Product> addItems() {
    var list = List<Product>();
    list = tmpData.map((e) => Product.fromMap(e)).toList();
    return list;
  }
}
