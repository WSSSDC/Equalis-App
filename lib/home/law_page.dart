import 'package:equalis/data/law_data.dart';
import 'package:equalis/data/profile.dart';
import 'package:equalis/elements/rounded_rect.dart';
import 'package:equalis/home/laws.dart';
import 'package:flutter/material.dart';

class LawPage extends StatefulWidget {
  const LawPage({required this.law, Key? key }) : super(key: key);

  final LawData law;

  @override
  _LawPageState createState() => _LawPageState();
}

class _LawPageState extends State<LawPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime expiryDate = DateTime.now();

  @override
  void initState() {
    hasVoted();
    startDate = widget.law.startDate;
    endDate = widget.law.endDate;
    expiryDate = widget.law.endDate.add(widget.law.duration);
    super.initState();
  }

  hasVoted() async {
    widget.law.hasUserVoted = await Profile.hasVoted(widget.law.lawId);
  }

  String term () {
    switch (widget.law.status) {
      case LawStatus.active:
        return 'Effective: ${endDate.day}/${endDate.month}/${endDate.year}';
      case LawStatus.inactive:
        return 'Voting starts: ${startDate.day}/${startDate.month}/${startDate.year}';
      case LawStatus.expired:
        return 'Expired on: ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}';
      case LawStatus.rejected:
        return 'Rejected on: ${endDate.day}/${endDate.month}/${endDate.year}';
      case LawStatus.pending:
        return 'Voting ends: ${endDate.day}/${endDate.month}/${endDate.year}';
      default:
        return 'Unknown';
    }
  }

  votePopup(bool approved) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to vote ' + (approved ? 'for' : 'against') + ' this law?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blueAccent)),
              onPressed: () {
                widget.law.vote(approved);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            TextButton(
              child: Text('No', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).padding.top + 30.0, 30.0, 0.0),
            children: [
              Text(widget.law.title, style: Theme.of(context).textTheme.headline1),
              Container(height: 10.0),
              Text(term(), style: Theme.of(context).textTheme.subtitle1),
              Container(height: 15.0),
              Text(widget.law.description, style: Theme.of(context).textTheme.bodyText1),
              Container(height: 15.0),
              LawBar(law: widget.law),
              Container(height: 15.0),
              Text(widget.law.lawBody, style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.5, fontWeight: FontWeight.w600)),
              Container(height: 170.0)
            ],
          ),
          !widget.law.hasUserVoted ?
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 40, left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundedRectangle(
                    onTap: () {
                      votePopup(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(child: Text("ACCEPT", style: Theme.of(context).textTheme.subtitle1)),
                    )
                  ),
                  Container(height: 5.0),
                  RoundedRectangle(
                     onTap: () {
                      votePopup(false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(child: Text("REJECT", style: Theme.of(context).textTheme.subtitle1)),
                    )
                  ),
                ],
              ),
            )
          ) : Container()
        ],
      ),
    );
  }
}