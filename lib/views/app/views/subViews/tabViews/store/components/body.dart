import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grocery_app/blocs/catalog/catalog_bloc.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/dummy/prods.dart';
import 'package:grocery_app/views/app/views/subViews/tabViews/details/prod_details.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';

import 'categories.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  final List<Product> products;
  const Body({
    Key key,
    this.products,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> _productFiltered = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productFiltered =
        widget.products.where((prod) => prod.category == 'Indica').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _promotion(),
        Categories(
          onSelected: (selected) {
            setState(() {
              _productFiltered = widget.products
                  .where((prod) => prod.category == selected)
                  .toList();
            });

            // Helper.debugLog('store > body > cat callback', products);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                itemCount: _productFiltered.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: _productFiltered[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: _productFiltered[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }

  Widget _promotion() {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 5),
            height: 100.0,
            viewportFraction: 1.0,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
          ),
          items: [1, 2].map((index) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.weedmaps.com/pictures/users/005/923/874/large/83767328_88C200FE-9B70-4179-BF77-B37BB4510129.jpeg'),
                            fit: BoxFit.fitWidth)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        index == 1 ? '25% OFF' : '20% OFF',
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                  offset: Offset(3.0, 5.0),
                                  blurRadius: 3.0,
                                  color: Colors.white70)
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                          index == 2 ? 'Return Customer?' : 'New Customer?',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )
                ]);
              },
            );
          }).toList(),
        ));
  }
}
