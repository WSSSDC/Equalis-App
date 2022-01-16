import 'package:equalis/data/law_data.dart';
import 'package:equalis/data/profile.dart';
import 'package:equalis/elements/rounded_rect.dart';
import 'package:equalis/home/Laws.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<LawData> _newLaws = Profile.laws;

  @override
  void initState() {
    _newLaws.sort((a, b) => b.endDate.compareTo(a.endDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).padding.top + 30.0, 30.0, 0.0),
      children: [
        Text("Hello " + Profile.firstName + "!", style: Theme.of(context).textTheme.headline1),
        Container(height: 20.0),
        Text("The federal election is", style: Theme.of(context).textTheme.subtitle2),
        Text("November 6, 2022", style: Theme.of(context).textTheme.headline2),
        Container(height: 20.0),
        Text("New Laws", style: Theme.of(context).textTheme.subtitle1),
        Container(height: 10),
        ..._newLaws.where((law) => law.status == LawStatus.pending).map((law) => Law(law: law)),
        Container(height: 20.0),
        Text("Recently Passed", style: Theme.of(context).textTheme.subtitle1),
        ..._newLaws.where((law) => law.status == LawStatus.active).map((law) => Law(law: law)),
      ],
    );
  }
}