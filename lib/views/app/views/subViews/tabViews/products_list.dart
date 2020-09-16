import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/catalog/bloc.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/dummy/prods.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/widgets/app_widgets/custom_listitem.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';

class ProdsView extends StatefulWidget {
  final String catName;
  ProdsView({Key key, this.catName}) : super(key: key);

  @override
  _ProdsViewState createState() => _ProdsViewState();
}

class _ProdsViewState extends State<ProdsView> {
  //test data
  // List<Product> listOrders = tmpData.map((e) => Product.fromMap(e)).toList();
  @override
  Widget build(BuildContext context) {
    String categoryName = widget.catName;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('$categoryName - Products'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _prodsList(categoryName),
      ),
    );
  }

  Widget _prodsList(String categoryName) {
    return BlocBuilder<CatalogBloc, CatalogStates>(
      builder: (context, state) {
        if (state is CatalogLoading) {
          return Center(child: loadingProgress);
        } else if (state is CatalogLoaded) {
          List<Product> listItem = state.catalog.products
              .where((prod) => prod.category == categoryName)
              .toList();
          return _ListViewProds(
            listData: listItem,
            layoutCard: true,
          );
        }
        return Text('Something Wrong');
      },
    );
  }
}

class _ListViewProds extends StatefulWidget {
  _ListViewProds({
    Key key,
    this.listData,
    this.layoutCard,
    this.parentView,
  }) : super(key: key);

  final List<dynamic> listData;
  final bool layoutCard;
  final String parentView;

  @override
  _ListViewProdsState createState() => _ListViewProdsState();
}

class _ListViewProdsState extends State<_ListViewProds> {
  var _listData = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _listOrders = widget.listData;
    _listData = widget.listData;
    // Helper.debugLog('list_orders > initState > _listData', _listData);

    // _listData.sort((a, b) => a.status.compareTo(b.status));

    return Container(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _listData.length,
              itemBuilder: (context, index) {
                final item = _listData[index];
                // Helper.debugLog('list_orders > ListView > item', item);
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, ProdDetailRoute),
                    child: _historyCard(
                      item,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _historyCard(
    dynamic item,
  ) {
    // if (player == null) return Text('under construction');
    // Helper.debugLog('list_orders > _historyCard > item', item);
    Product _prod = item as Product;
    var _defaultSize = Helper.settingSize(context)['fontSize'];

    return CustomListItem(
      thumbnail: Image.network(_prod.uriImg),
      color: Colors.white,
      title: '${_prod.name}',
      subtitle: '${_prod.price} · ${_prod.weight}',
      author: '${_prod.category}',
      statusSecPos: 'left',
      fontSize: _defaultSize,
      statusSec: [
        Text(
          'promotion off',
          style: TextStyle(
            fontSize: _defaultSize + 3,
            color: Colors.red,
          ),
        ),
        SizedBox(
          width: 1,
        ),
        Container(
          margin: EdgeInsets.only(right: 8),
          child: FlatButton(
            color: Colors.green,
            onPressed: () {
              // Navigator.pushNamed(context, '/main',
              //     arguments: <String, dynamic>{'index': 1, 'data': _order});
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.green, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
