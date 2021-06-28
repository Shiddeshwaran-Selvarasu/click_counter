import 'package:click_counter/pages/enterusername.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Settings extends StatefulWidget {

  final Function intChange;
  final primarytheme;
  String userName;
  int theme;


  Settings({required this.primarytheme, required this.theme,required this.intChange,required this.userName});

  @override
  _SettingsState createState() => _SettingsState(primarytheme,theme,intChange);
}

class _SettingsState extends State<Settings> {
  _SettingsState(this.primarytheme,this.theme, this.intChange);

  final myController = TextEditingController();

  final Function intChange;
  final primarytheme;
  int theme;

  var dropdownValue;

  @override
  void initState() {
    super.initState();
    setValue(theme);
  }

  setValue(int num){
    if(num == 0){
      dropdownValue = 'Light';
    } else if (num == 1){
      dropdownValue = 'Dark';
    } else {
      dropdownValue = 'System default';
    }
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

  setTheme(int i) async{
    final prefs1 = await SharedPreferences.getInstance();
    prefs1.setInt('theme', i);
  }

  themeSwitcher(int i){
    intChange(i);
    setTheme(i);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Settings',
        theme: ThemeData.light(),
        themeMode: themeChange(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Settings'),
            ),
            body: Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                           children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children:[
                                 Text('Apperance',style: TextStyle(color: primarytheme()),)
                              ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 20),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text('App Theme:', style: TextStyle(fontSize: 15),),
                                      DropdownButton<String>(
                                                value: dropdownValue,
                                                icon: const Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                onChanged: (String? newValue) {
                                                  int num;
                                                  setState(() {
                                                    dropdownValue = newValue;
                                                    if(dropdownValue == 'Light'){
                                                      num = 0;
                                                      theme = 0;
                                                    } else if(dropdownValue == 'Dark'){
                                                      num = 1;
                                                      theme = 1;
                                                    } else{
                                                      num = 2;
                                                      theme = 2;
                                                    }
                                                    themeSwitcher(num);
                                                  });
                                                },
                                                items: <String>['Light', 'Dark', 'System default']
                                                .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                    );
                                                 }).toList(),
                                      ),
                               ],
                             ),
                           ),
                           Divider(color: Colors.grey, thickness: 0.5,),
                           Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                        Text('Profile', style: TextStyle(color: primarytheme()),),
                                    ],)),

                           MaterialButton(
                               onPressed: () {
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => EnterUserName(userName: 'change',)));
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                 Text('Change UserName:',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
                                 Text(widget.userName,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
                                 ],
                             ),
                             ),
                           Divider(color: Colors.grey, thickness: 0.5,),
                        ],
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
