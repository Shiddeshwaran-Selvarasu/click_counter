import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Leaderboard extends StatefulWidget {

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  var list;
  List<String> names = [];
  List<int> clicks = [];
  List<int> clicksSorted = [];
  late Map<int, String> clickName;

  DatabaseReference test = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    getCounter();
  }

  Widget namesSet(int tp) {
    try {
      return Text(clickName[clicks[tp]].toString());
    } catch (e){
      return Text('Null');
    }
  }

  Widget clickSet(int tp) {
    try {
      return Text(clicks[tp].toString());
    } catch (e){
      return Text('-');
    }
  }

   getCounter() {
      setState(() {
        test.once().then((DataSnapshot data) {
        var keys = data.value.keys;
        list = data.value;
        names.clear();
        clicks.clear();
        for(var key in keys) {
          names.add(key.toString());
          clicks.add(list[key]);
        }
        clickName = Map.fromIterables(clicks, names);
        clicksSorted = clicks;
        clicksSorted.sort((a, b) => b.compareTo(a));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 Text('Position',style:TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text('#1'),
                  SizedBox(height: 20,),
                  Text('#2'),
                  SizedBox(height: 20,),
                  Text('#3'),
                  SizedBox(height: 20,),
                  Text('#4'),
                  SizedBox(height: 20,),
                  Text('#5'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  namesSet(0),
                  SizedBox(height: 20,),
                  namesSet(1),
                  SizedBox(height: 20,),
                  namesSet(2),
                  SizedBox(height: 20,),
                  namesSet(3),
                  SizedBox(height: 20,),
                  namesSet(4),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Clicks',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  clickSet(0),
                  SizedBox(height: 20,),
                  clickSet(1),
                  SizedBox(height: 20,),
                  clickSet(2),
                  SizedBox(height: 20,),
                  clickSet(3),
                  SizedBox(height: 20,),
                  clickSet(4),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
