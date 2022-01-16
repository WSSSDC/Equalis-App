import 'package:flutter/material.dart';

class Election extends StatefulWidget {
  const Election({ Key? key }) : super(key: key);

  @override
  _ElectionState createState() => _ElectionState();
}

class _ElectionState extends State<Election> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).padding.top + 30.0, 30.0, 0.0),
      children: [
        Text("Federal Election", style: Theme.of(context).textTheme.headline1),
        Container(height: 100),
        Center(
          child: Column(
            children: [
              Text("23 Days", style: Theme.of(context).textTheme.subtitle1),
              Text("2 Hours", style: Theme.of(context).textTheme.subtitle1),
              Text("16 Minutes", style: Theme.of(context).textTheme.subtitle1),
              Text("48 Seconds", style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      ],
    );
  }
}