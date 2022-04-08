import 'package:cofee_brew_1/models/user.dart';
import 'package:cofee_brew_1/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<MyUser?>(context);

   //return either home or authenticate widget
    if (user == null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}
