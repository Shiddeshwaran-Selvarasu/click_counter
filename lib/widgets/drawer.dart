import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/info.dart';
import '../pages/settings.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  final String title;
  final Function primaryTheme;
  final Function intChange;
  int theme;

  DrawerWidget({required this.title, required this.primaryTheme,required this.userName,required this.theme,required this.intChange});
  final userName;

  void _launchURL() async {
    const url = 'https://forms.gle/W59QkMjG5gV452rR9';
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Material(
            child: ListView(

              children: <Widget>[

                Container(
                  padding: EdgeInsets.symmetric(vertical:  20,horizontal: 10,),
                  color: primaryTheme(),
                  child: Row(
                    children: [
                      InkWell(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/profile_edit.png'),
                          ),
                        ),
                      const SizedBox(width: 20,),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text('$userName', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 25,),

              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            Settings(primarytheme: primaryTheme,theme:  theme,intChange: intChange,userName: userName,))
                    );
                  },
                ),

                const SizedBox(height: 16,),

                Divider(color: Colors.grey, thickness: 1.5, ),

                const SizedBox(height: 16,),

                ListTile(
                  leading: Icon(Icons.feedback_rounded),
                  title: Text('Feedback (Google Forms)'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _launchURL();
                  },
                ),

                const SizedBox(height: 16,),


                ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text('About App'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Info(primarytheme: primaryTheme,theme: theme,)),
                    );
                  },
                ),
                const SizedBox(height: 16,),
              ],
            ),
          )
      ),

    );
  }
}
