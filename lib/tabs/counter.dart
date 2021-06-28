import 'package:flutter/material.dart';


class Counter extends StatefulWidget {

  final _counternum;
  Function buttonpressed;
  String userName;

  Counter( this._counternum, this.buttonpressed,this.userName);

  @override
  _CounterState createState() => _CounterState(userName: userName);
}

class _CounterState extends State<Counter> {
  TextEditingController myController = TextEditingController();

  _CounterState({required this.userName});

  String userName;

  @override
  Widget build(BuildContext context) {
    return  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' '),
              Text('Number of Clicks: '+'${widget._counternum}', style: Theme.of(context).textTheme.headline5,),
              ElevatedButton(
                  onPressed: () { widget.buttonpressed(); },
                  style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(300),
                                ),
                          )
                  ),
                  child: Icon(Icons.add, size: 20,)),
              Text(' '),
            ],
        );
  }
}

