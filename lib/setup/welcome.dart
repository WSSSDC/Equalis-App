import 'package:equalis/data/profile.dart';
import 'package:equalis/elements/rounded_rect.dart';
import 'package:equalis/setup/qr-scan.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    Profile.getElectionStatus("8");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Container(height: 50),
            Center (
              child: Text('Equalis', style: Theme.of(context).textTheme.headline1),
            ),
            Expanded(child: Container()),
            RoundedRectangle(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QRScan()));
              },
              color: Colors.greenAccent,
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Sign Up", 
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 25.0)
                ),
              )
            ),
            Container(height: 8.0)
          ],
        ),
      ),
    );
  }
}