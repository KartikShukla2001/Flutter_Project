import 'package:cofee_brew_1/models/user.dart';
import 'package:cofee_brew_1/services/database.dart';
import 'package:cofee_brew_1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cofee_brew_1/shared/constants.dart';
import 'package:cofee_brew_1/models/user.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey =GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

    late String _currentName='';
   late String _currentSugars= '0';
   late int _currentStrength=100;

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData =snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val)  => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                   value: _currentSugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val)  => setState(() => _currentSugars = val as String),
                ),
                //slider
                Slider(
                  value: (_currentStrength ?? userData.strength).roundToDouble(),
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength=val.round()),),
                RaisedButton(
                  color: Colors.deepPurpleAccent[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),

          );
        }
        else{
            return Loading();
        }

      }
    );
  }
}
