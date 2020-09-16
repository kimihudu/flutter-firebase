import 'package:flutter/material.dart';

import 'loader5.dart';
import 'loader3.dart';

/**
 * 042120lk - widget for loading dicator
*/
Widget loadingProgress = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Center(
      child: Container(
        width: 300.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(10.0),
        ),
        alignment: AlignmentDirectional.center,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: new Center(
                child: new Text(
                  "Loading...",
                  style: new TextStyle(color: Colors.red[200]),
                ),
              ),
            ),
            new Center(
              child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: ColorLoader3(
                    radius: 15,
                    dotRadius: 6,
                  )
                  // new CircularProgressIndicator(
                  //   value: null,
                  //   strokeWidth: 7.0,
                  // ),
                  ),
            ),
          ],
        ),
      ),
    ),
  ],
);

/**
 * 051120lk - 404 page
*/
Widget page404(BuildContext context, String content) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              borderRadius: new BorderRadius.circular(10.0)),
          width: 300.0,
          height: 300.0,
          alignment: AlignmentDirectional.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: new Center(
                  child: new Text(
                    "$content",
                    style: new TextStyle(
                      color: Colors.red[200],
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "Go Back",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  // debugLog('oopAlert', context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => LaunchGame(
                  //       title: 're-Launch Game',
                  //     ),
                  //   ),
                  // );
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

//051220lk - overlay waiting process
showOverlay(BuildContext context, String title, int second) async {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      child: Container(
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ColorLoader5(),
            ],
          )),
    ),
  );
  overlayState.insert(overlayEntry);

  await Future.delayed(Duration(seconds: second));

  overlayEntry.remove();
}
