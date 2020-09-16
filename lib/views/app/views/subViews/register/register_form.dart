import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/routing/route_names.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'components/register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;
  Image pickedImage;
  Uint8List upImg;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        //* Success register
        //* nav to Store index
        //* get user info from AuthenticationLoggedIn
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());

          Navigator.pushNamed(context, MainAppViewRoute,
              arguments: {'index': 0, 'data': null});
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  _uploadFile(),
                  RegisterButton(
                      onPressed: () => isRegisterButtonEnabled(state)
                          ? _onFormSubmitted()
                          : null),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _uploadFile() {
    //get file upload
    // naming file with email
    // upload to POS/credential
    // update firestore/users with storage url
    // for admin verify
    // search user with status pendinf
    // get storage url
    // view pic on view widget
    // update firestore/users status: true/false
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            child: SizedBox(
                  width: 200,
                  child: pickedImage,
                ) ??
                Container(),
          ),
          Container(
              child: RaisedButton(
            onPressed: () => pickImage(),
            child: Text('Select Image'),
          ))
        ]);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
          email: _emailController.text,
          password: _passwordController.text,
          img8: upImg),
    );
  }

  pickImage() async {
    /// You can set the parameter asUint8List to true
    /// to get only the bytes from the image
    /* Uint8List bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (bytesFromPicker != null) {
      debugPrint(bytesFromPicker.toString());
    } */

    /// Default behavior would be getting the Image.memory
    /// read img source to memory
    Uint8List imgData =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    Image fromPicker = Image.memory(imgData);

    if (fromPicker != null) {
      setState(() {
        pickedImage = fromPicker;
        upImg = imgData;
      });
    }
  }
}
