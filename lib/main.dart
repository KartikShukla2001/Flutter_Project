import 'package:cofee_brew_1/models/user.dart';
import 'package:cofee_brew_1/screens/wrapper.dart';
import 'package:cofee_brew_1/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp app;

  try {
    app = await Firebase.initializeApp(
      name: 'my_app',
      options: FirebaseOptions(
        appId: 'YOUR_APP_ID',
        apiKey: 'YOUR_API_KEY',
        databaseURL: 'your_database_url',
        projectId: 'your_project_id',
        messagingSenderId: 'your_msid',
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      app = Firebase.app('my_app');
    } else {
      throw e;
    }
  } catch (e) {
    rethrow;
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
         home: Wrapper(),
      ),
    );
  }
}

