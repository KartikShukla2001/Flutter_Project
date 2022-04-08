import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cofee_brew_1/screens/home/settings_form.dart';
import 'package:cofee_brew_1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cofee_brew_1/services/auth.dart';
import 'package:cofee_brew_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brew_list.dart';
import 'package:cofee_brew_1/models/brew.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 70.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent[50],
        appBar: AppBar(
          title: Text(('Brew Crew')),
          backgroundColor: Colors.deepPurpleAccent[400],
          elevation: 0.0 ,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async{
                 await _auth.signOut();
            }, icon: Icon(Icons.person), label: Text('logout')),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
