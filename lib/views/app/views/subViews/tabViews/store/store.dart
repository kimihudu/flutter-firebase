import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/widgets/app_widgets/app_bar_wg.dart';
import 'package:grocery_app/widgets/app_widgets/loaders/loading_indicator.dart';

import 'components/body.dart';

class MyStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<CatalogBloc, CatalogStates>(
      builder: (context, state) {
        if (state is CatalogLoading) {
          return Center(child: loadingProgress);
        } else if (state is CatalogLoaded) {
          List<Product> products = state.catalog.products;
          return Body(
            products: products,
          );
        }
        return Container(
          child: Text('Something Wrong'),
        );
      },
    );
  }
}
