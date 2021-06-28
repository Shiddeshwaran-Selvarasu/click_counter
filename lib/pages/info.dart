import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {

  final primarytheme;
  int theme;

  themeChange(){
    if(theme == 0){
      return ThemeMode.light;
    } else if (theme == 1){
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Info({required this.primarytheme,required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Info',
        theme: ThemeData.light(),
        themeMode: themeChange(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Info'),
          ),
         body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/app_icon.png'),
                    ),
                    SizedBox(height: 10,),
                    Text('Click Counter', style: TextStyle(fontSize: 25, fontFamily: 'latin',),),
                  ],
                ),
              ),

               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                                 children:[
                                   _infowidgets(icon: Icons.people_outline_outlined,title: 'Developers:',content: 'Shiddeshwaran.S and Yokesh.G',content2: ' ',),
                                   SizedBox(height: 15,),
                                   _infowidgets(icon: Icons.info_outline_rounded,title: 'Version:',content: '4.0.7',content2: ' ',),
                                   SizedBox(height: 15,),
                                   _infowidgets(icon: Icons.image_outlined,title: 'App icon Source:',content: 'icon-icons.com', content2: ' ',),
                                   SizedBox(height: 15,),
                                   _infowidgets(icon: Icons.mail_rounded,title: 'Contact:',content: 'shiddeshwaran@gmail.com,',content2: '\nyokeshlegend007@gmail.com',),
                                  ]
                ),
                      ),

                ),
              ),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
               },
               child: Text('Exit'))
          ],
        )
       )
      )
    );
  }
}

class _infowidgets extends StatelessWidget{

  _infowidgets({this.icon,this.title,this.content,this.content2});

  final icon;
  final title;
  final content;
  final content2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 45,),
          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Text('$title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
              SizedBox(height: 5,),
            Text('${content.toString()}'+'$content2',),
            ],
          ),
        ],
      ),
    );
  }
}