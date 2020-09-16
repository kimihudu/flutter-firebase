import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/repo/user_repo.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:grocery_app/views/app/views/pre_login.dart';

import 'package:grocery_app/views/app/views/welcome.dart';
import 'package:grocery_app/views/home/home_view.dart';
import 'package:grocery_app/views/app/views/subViews/sub_views.dart';
import 'package:grocery_app/views/app/views/index.dart';

import 'views/subViews/login/login_view.dart';

import 'views/subViews/tabViews/my_cart_ext.dart';
// import 'package:firebase/firebase.dart' as firebase;

class AppContentMobile extends StatefulWidget {
  AppContentMobile({Key key}) : super(key: key);

  @override
  _AppContentMobileState createState() => _AppContentMobileState();
}

class _AppContentMobileState extends State<AppContentMobile> {
  UserRepository userRepository = UserRepository();
  // FirebaseApp firebaseApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initFirebaseApp();
  }

  // void initFirebaseApp() async {
  //   firebaseApp = await FirebaseApp.configure(
  //     name: 'firebaseStore',
  //     options: FirebaseOptions(
  //       googleAppID: AppSetting.firebaseConfig['googleAppID'],
  //       apiKey: AppSetting.firebaseConfig['apiKey'],
  //       projectID: AppSetting.firebaseConfig['projectId'],
  //       storageBucket: AppSetting.firebaseConfig['storageBucket'],
  //     ),
  //   );

  //   userRepository = UserRepository(
  //       fireStore: Firestore(app: firebaseApp),
  //       storage: FirebaseStorage(app: firebaseApp),
  //       firebaseAuth: FirebaseAuth.fromApp(firebaseApp));
  // }

  @override
  Widget build(BuildContext context) {
    // firebase.initializeApp(
    //   apiKey: AppSetting.firebaseConfig['apiKey'],
    //   storageBucket: AppSetting.firebaseConfig['storageBucket'],
    //   projectId: AppSetting.firebaseConfig['projectId']
    // );

    return AspectRatio(
      aspectRatio: 5 / 6,
      child: Column(
        children: <Widget>[
          // WelcomeView(),
          Expanded(
            child: Container(
                color: Colors.yellow[300],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<CatalogBloc>(
                      create: (_) => CatalogBloc()..add(CatalogStarted()),
                    ),
                    BlocProvider<CartBloc>(
                      create: (_) => CartBloc()..add(CartStarted()),
                    ),
                    BlocProvider<AuthenticationBloc>(
                        create: (_) =>
                            AuthenticationBloc(userRepository: userRepository)),
                  ],
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'FarmerLink',
                    theme: ThemeData(
                      brightness: Brightness.light,
                      primarySwatch: Colors.amber,
                    ),
                    home: WelcomeView(),
                    routes: {
                      LoginRoute: (context) =>
                          LoginViewExt(userRepository: userRepository),
                      HomeRoute: (context) => HomeView(),
                      // StoreRoute: (context) => StoreView(),
                      // ProdsRoute: (context) => ProdsView(),
                      MyCartRoute: (context) => CartScreen(),
                      MyAccRoute: (context) => AccountView(),
                      CheckOutRoute: (context) =>
                          CheckOutScreen(), //CheckOutView(),
                      MainAppViewRoute: (context) => MainAppView(),
                      ConfirmRoute: (context) => ConfirmView(),
                      PreLoginRoute: (context) => InterfereView(),

                      // RegisterUpPicRoute: (context) => RegisterCam()
                      // RegisterUploadPic()

                      //
                      // ProdDetailRoute: (context) =>
                      //ProductDetailsView(heroTag: "prod"),
                    },
                  ),
                )),
          )
        ],
      ),
    );
  }
}
