import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/repo/repos.dart';

class RegisterCam extends StatefulWidget {
  RegisterCam({Key key}) : super(key: key);

  @override
  _RegisterCamState createState() => _RegisterCamState();
}

class _RegisterCamState extends State<RegisterCam> {
  // Webcam widget to insert into the tree
  Widget _webcamWidget;
  // VideoElement
  VideoElement _webcamVideoElement;
  @override
  void initState() {
    super.initState();
    // Create a video element which will be provided with stream source
    _webcamVideoElement = VideoElement();
    // Register an webcam

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'webcamVideoElement', (int viewId) => _webcamVideoElement);
    // Create video widget
    _webcamWidget =
        HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');
    // Access the webcam stream
    window.navigator.getUserMedia(video: true).then((MediaStream stream) {
      _webcamVideoElement.srcObject = stream;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Webcam MediaStream:',
                style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
              ),
              Container(width: 300, height: 200, child: _webcamWidget),
              Expanded(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _webcamVideoElement.play();
                      },
                      child: Text('play'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // base64.decode(val.);
                        _webcamVideoElement.pause();
                        // var k =
                        //     _webcamVideoElement.srcObject.getVideoTracks().last;
                        // k.contentHint;
                        // var frmData = base64.decode(k.toString());
                        // _webcamVideoElement.on.listen((event) {
                        //   Helper.debugLog('webcam', event.toString());
                        // });
                        // UserRepository()
                        //     .uploadPic('sgqaservice@gmail.com', frmData);
                      },
                      child: Text('pause'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _webcamVideoElement.srcObject.active
              ? _webcamVideoElement.play()
              : _webcamVideoElement.pause(),
          tooltip: 'Start stream, stop stream',
          child: Icon(Icons.camera_alt),
        ),
      );
}
