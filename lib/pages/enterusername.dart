import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './mainpage.dart';

class EnterUserName extends StatefulWidget {
  EnterUserName({required this.userName});

  final userName;

  @override
  _EnterUserNameState createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {


  String userName = '';
  int theme = 2;

  @override
  void initState() {
    super.initState();
    getUserName();
    getTheme();
  }

  intChange(int i){
    setState(() {
      theme = i;
    });
  }

  setUserName(String text) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', text);
  }

  setTheme(int i) async{
    final prefs1 = await SharedPreferences.getInstance();
    prefs1.setInt('theme', i);
  }

  TextEditingController myController = TextEditingController();


  getUserName() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userName') != null){
    userName = (prefs.getString('userName')) as String;
    setState(() {
      userName = (prefs.getString('userName')) as String;
    });}
  }

  getTheme() async{
    final prefs1 = await SharedPreferences.getInstance();
    setState(() {
      if (prefs1.getInt('theme') == 0) {
        theme = 0;
      } else if (prefs1.getInt('theme') == 1) {
        theme = 1;
      } else {
        theme = 2;
      }
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

  @override
  Widget build(BuildContext context) {
    getUserName();
    getTheme();
    if(userName == '' || widget.userName == 'change'){
    return MaterialApp(
      theme: ThemeData.light(),
      themeMode: themeChange(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Click Counter'),),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border:  UnderlineInputBorder(),
                    hintText: 'Enter your UserName',
                  ),
                ),
                Text(' '),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: (){
                    String tempusername = myController.text;
                    if(tempusername != ''){
                      setUserName(tempusername);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => MainPage(title: 'Click Counter',userName: tempusername,theme: theme,intChange: intChange,)));
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Warning!'),
                          content: Text('Enter the username correctly'),
                          actions: [
                            TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('OK'),),
                          ],
                        ),
                        barrierDismissible: false,
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
   } else {
      return MainPage(title: 'Click Counter', userName: userName,theme: theme,intChange: intChange,);
    }
  }
}
