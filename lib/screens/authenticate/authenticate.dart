import 'package:cofee_brew_1/screens/authenticate/register.dart';
import 'package:cofee_brew_1/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn =true;
  void toggleView(){
    setState(() => showSignIn =!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return Sign_In(toggleView: toggleView);
    }
    else
      {
        return Register(toggleView: toggleView);
      }
  }
}
