import 'package:equalis/data/law_data.dart';
import 'package:equalis/data/profile.dart';
import 'package:equalis/elements/rounded_rect.dart';
import 'package:equalis/home/law_page.dart';
import 'package:flutter/material.dart';

class Laws extends StatefulWidget {
  const Laws({ Key? key }) : super(key: key);

  @override
  _LawsState createState() => _LawsState();
}

class _LawsState extends State<Laws> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(30.0, MediaQuery.of(context).padding.top + 30.0, 30.0, 0.0),
      children: [
        Text("Laws", style: Theme.of(context).textTheme.headline1),
        Container(height: 15.0),
        ...Profile.laws.map((law) => Law(law: law)
        ),
      ],
    );
  }
}

class Law extends StatefulWidget {
  const Law({required this.law, Key? key }) : super(key: key);

  final LawData law;

  @override
  _LawState createState() => _LawState();
}

class _LawState extends State<Law> {

  Color colorthing () {
    if (widget.law.status == LawStatus.active) {
      return Colors.green;
    } else if (widget.law.status == LawStatus.inactive) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RoundedRectangle(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => LawPage(law: widget.law)));
        },
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorthing(),
                  radius: 10.0,
                ),
                Container(width: 8.0),
                Text(widget.law.title, style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
            Container(height: 8.0),
            Text(widget.law.description, style: Theme.of(context).textTheme.bodyText2),
            Container(height: 12.0),
            LawBar(law: widget.law),
          ],
        )
      ),
    );
  }
}

class LawBar extends StatelessWidget {
  const LawBar({required this.law, Key? key }) : super(key: key);

  final LawData law;

  @override
  Widget build(BuildContext context) {
    return RoundedRectangle(
      child: Row(
        children: [
          Expanded(
            flex: law.votesFor,
            child: Container(
              height: 10.0,
              color: Theme.of(context).highlightColor
            )
          ),
          Expanded(
            flex: law.votesAgainst,
            child: Container(
              height: 10.0,
              color: Theme.of(context).errorColor
            )
          ),
          Expanded(
            flex: law.totalVotes - law.votesFor - law.votesAgainst,
            child: Container(
              height: 10.0,
              color: Colors.grey
            )
          )
        ],
      ),
    );
  }
}