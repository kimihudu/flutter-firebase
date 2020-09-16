// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grocery_app/blocs/blocs.dart';

// class Dev extends StatefulWidget {
//   Dev({Key key}) : super(key: key);

//   @override
//   _DevState createState() => _DevState();
// }

// class _DevState extends State<Dev> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _loadData(),
//     );
//   }

//   Widget _loadData() {
//     return BlocBuilder<CatalogBloc, CatalogStates>(
//       builder: (context, state) {
//         if (state is CatalogLoading) {
//           return CircularProgressIndicator();
//         } else if (state is CatalogLoaded) {

//           return ListView.builder(
//             itemCount: ,
//             itemBuilder: (context, index) {

//           },)
//         }
//       },
//     );
//   }
// }
