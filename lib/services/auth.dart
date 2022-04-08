import 'package:cofee_brew_1/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign-in anon

  //create user based on FirebaseUser
   MyUser? _userFromFirebaseUser(User ? user) {
     return user != null ? MyUser(uid: user.uid) : null;
   }

   // auth change user stream
  Stream<MyUser?> get user{
     return _auth.authStateChanges()
          .map(_userFromFirebaseUser);
  }

   Future signInAnon() async {
     try{
       UserCredential result = await _auth.signInAnonymously();
       User? user  = result.user;
       return _userFromFirebaseUser(user!);
     }
     catch(e){
      print(e.toString());
      return null;
     }
   }
  //sign-in with email
  Future signInWithEmailandPassword(String email,String password) async{
    try{
      UserCredential result =  await _auth.signInWithEmailAndPassword(email: email ,password: password);
      User? user =result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email
  Future registerWithEmailandPassword(String email,String password) async{
     try{
       UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email ,password: password);
       User? user =result.user;

       //Create a new document when the user registers
        await DatabaseService(uid: user!.uid).updateUserData('0','new crew member',100);

       return _userFromFirebaseUser(user);
     }catch(e){
      print(e.toString());
      return null;
     }
  }

  //signout
Future signOut() async {
     try{
       return await _auth.signOut();
     } catch(e){
       print(e.toString());
       return null;
     }
}
}