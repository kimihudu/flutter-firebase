// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/constants/setting.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:firebase/firebase.dart' as fb;
//import 'package:firebase_storage/firebase_storage.dart'; // this not yet support to web ver

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Firestore _fireStore;

  UserRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignin,
    Firestore fireStore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn(),
        _fireStore = fireStore ?? Firestore.instance;

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> signUp({String email, String password, Uint8List img8}) async {
    //* add to firebase authentication
    var newOauth = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    //* create a use doc in users collection
    var newUser = await _fireStore.collection('users').add(User(
          email: newOauth.user.email,
          verified: false,
        ).toMap());

    String _photoId = await uploadPic(newOauth.user.email, img8);

    newUser.updateData({
      'img': _photoId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    return newUser.documentID;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<User> getUser() async {
    String _email = (await _firebaseAuth.currentUser()).email;
    User _user = await _queryBy('users', 'email', _email);
    return _user;
  }

  Future<dynamic> _queryBy(String collection, String field, String val) async {
    var callback;
    try {
      callback = await _fireStore
          .collection(collection)
          .where(field, isEqualTo: val)
          .snapshots()
          .map((snapshot) =>
              snapshot.documents.map((doc) => User.fromSnapshot(doc)).first)
          .first;
    } catch (e) {
      Helper.debugLog('user_repo > getUser > not found ', val);
    }
    return callback;
  }

/**
 * uploadPic: upload new register user
 * param: img - bytes array
 * param: file - enum - opt
 * return: download url
*/
  Future<String> uploadPic(String userEmail, Uint8List img,
      [html.Blob file]) async {
    String fileName = '$userEmail.png';

    fb.StorageReference storeRef =
        fb.storage().ref(AppSetting.dirCredential + fileName);

    fb.UploadTaskSnapshot uploadTask = await storeRef.put(img).future;

    Uri url = await uploadTask.ref.getDownloadURL();
    return url.toString();
  }

  Future<void> updateUser(User user, String updateInfo) async {}
}
