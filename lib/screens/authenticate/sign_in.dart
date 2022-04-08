import 'package:cofee_brew_1/services/auth.dart';
import 'package:cofee_brew_1/shared/constants.dart';
import 'package:cofee_brew_1/shared/loading.dart';
import 'package:flutter/material.dart';

class Sign_In extends StatefulWidget {
  final Function toggleView;
  Sign_In({required this.toggleView});
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final AuthService _auth = AuthService();
  final _formKey =GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
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
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 7 ? 'Enter a password 7+ chars long' : null,
                obscureText: true,
                onChanged: (val){
                setState(() => password = val);
                },
              ),
             SizedBox(height: 20.0),
              RaisedButton(color:Colors.brown[400],
                  child:Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),onPressed: () async{
                if(_formKey.currentState!.validate()){
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailandPassword(email, password);

                  if(result == null){
                    setState(()
                    {

                      error= 'could not sign in with those credentials';
                      loading = false;
                    });
                  }
                }
                     print(email);
                     print(password);
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              ),
            ],
          ),
        )
      ),
    );
  }
}
