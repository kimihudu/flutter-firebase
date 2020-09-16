import 'package:flutter/material.dart';

import 'package:grocery_app/constants/enum.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/widgets/call_to_action/call_to_action.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  final SelecteChangeCallBack onSelected;
  Categories({Key key, this.onSelected}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories =
      AppSetting.CATEGORIES.map((cat) => cat['name'].toString()).toList();
  // By default our first item will be selected
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onSelected(categories[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    selectedIndex == index ? Colors.black54 : Colors.grey[350],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20 / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
