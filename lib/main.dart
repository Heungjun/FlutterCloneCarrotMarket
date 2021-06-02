import 'package:clone_carrot_market/pages/home.dart';
import 'package:clone_carrot_market/pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if(snapshot.hasError) return Center(child: Text('Firebase Error'),);

      if(snapshot.connectionState == ConnectionState.done) return LoginChecker();
      return Center(child: CircularProgressIndicator(),);
    }, future: Firebase.initializeApp(),);
  }
}

class LoginChecker extends StatelessWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (BuildContext context,AsyncSnapshot<User?> user) {
      if(user.hasData) {
        return Home();
      } else {
        return SignIn();
      }
    }, stream: FirebaseAuth.instance.authStateChanges(),);
  }
}


