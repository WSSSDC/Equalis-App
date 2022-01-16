import 'package:equalis/data/profile.dart';
import 'package:equalis/setup/sin.dart';
import 'package:equalis/setup/verify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equalis/elements/rounded_rect.dart';

class Passport extends StatefulWidget {
  const Passport({ Key? key }) : super(key: key);

  @override
  _PassportState createState() => _PassportState();
}

class _PassportState extends State<Passport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify your identity", style: Theme.of(context).textTheme.headline1),
            Container(height: 8.0),
            Text("Enter your Passport Number", style: Theme.of(context).textTheme.subtitle1),
            Container(height: 16.0),
            CupertinoTextField(
              placeholder: "GA302922",
              onSubmitted: (value) {
                Profile.passportId = value;
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SIN()));
              },
            )
          ],
        ),
      ),
    );
  }
}