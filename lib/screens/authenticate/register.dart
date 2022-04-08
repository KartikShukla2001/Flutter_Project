import 'package:cofee_brew_1/services/auth.dart';
import 'package:cofee_brew_1/shared/constants.dart';
import 'package:cofee_brew_1/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey =  GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign-In'),
            onPressed: (){
                widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val!.isEmpty ? 'Énter an email' : null,
                    onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'PasswordS'),
                    validator: (val) => val!.length < 7 ? 'Enter  a assword 7+ chars long' : null,
                    obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(color:Colors.brown[400],
                    child:Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailandPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'please supply a valid email';
                            loading=false;
                          });
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 14.0),
                )
              ],
            ),
          )
      ),
    );
  }
}
