import 'package:click_counter/pages/enterusername.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

      @override
      Widget build(BuildContext context) {
         return MaterialApp(
           theme: ThemeData(primarySwatch: Colors.blue),
            home: FutureBuilder(
              future: _fbApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Error : ${snapshot.error.toString()}');
                  return Text('Something went wrong!');
                } else if (snapshot.hasData) {
                   return EnterUserName(userName: '',);
                } else {
                  return MaterialApp(
                      home: Scaffold( body: Center(child: CircularProgressIndicator(color: Colors.red,),)));
                }
              },
            )
        );
      }
}