import 'package:click_counter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../tabs/counter.dart';
import '../tabs/leaderboard.dart';


// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title, required this.userName,required this.theme,required this.intChange}) : super(key: key);

  final String title;
  final String userName;
  int theme;
  final Function intChange;

  @override
  _MainPageState createState() => _MainPageState(userName: userName,theme: theme,intChange1: intChange);
}

class _MainPageState extends State<MainPage> {
  _MainPageState({required this.userName,required this.theme,required this.intChange1});

  final userName;
  int _counter = 0;
  int databasecounter = 0;
  int theme;
  final Function intChange1;


  _primaryTheme() {
    return Colors.blue;
  }

  void _incrementCounter() {
    DatabaseReference test = FirebaseDatabase.instance.reference();
    setState(() {
      _counter++;
    });

    test.child('$userName').once().then((DataSnapshot data){
      if (data.value != null) {
        databasecounter = data.value;
        print(databasecounter);
        setState(() {
          if (databasecounter < _counter) {
            test.child('$userName').set(_counter);
          }
        });
      }
    });
  }

  getData(){
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Name").once().then((DataSnapshot data){
      print(data.value);
      print(data.key);
    });
  }

  intChange(int i){
    setState(() {
      theme = i;
      print(i);
      intChange1(i);
    });
  }

  themeChange(){
    if(theme == 0){
      return ThemeMode.light;
    } else if (theme == 1){
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Click Counter',
      theme: ThemeData.light(),
      themeMode: themeChange(),
      darkTheme: ThemeData.dark(),
      home: DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(

            title: Text(widget.title),
            bottom: TabBar(
              indicatorColor: Colors.white,
              automaticIndicatorColorAdjustment: false,
              tabs: [
                Tab(text: "Click"),
                Tab(text: "Leader Board"),
              ],
            ),
          ),

          drawer: DrawerWidget(title: widget.title,primaryTheme: _primaryTheme,userName: userName,theme: theme,intChange: intChange,),
          body: TabBarView(
              children: [
                Counter(_counter, _incrementCounter,userName),
                Leaderboard(),
              ]
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            tooltip: 'Reset Counter',
            onPressed: _resetCounter,
          ),
        ),
      ),
    );
  }
}