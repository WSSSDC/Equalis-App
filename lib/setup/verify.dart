import 'package:equalis/data/profile.dart';
import 'package:equalis/home/home.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  const Verify({ Key? key }) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isLoading = true;
  bool verified = false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    verified = await Profile.getUserData();
    print(verified);
    setState(() {
      isLoading = false;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    if (verified) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Home()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading ? 
        const CircularProgressIndicator(color: Colors.black) :
        (verified ? const Icon(Icons.check, size: 60.0) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel, size: 60.0),
            const SizedBox(height: 10.0),
            Text('Verification failed', style: Theme.of(context).textTheme.subtitle1),
          ],
        )),
      ),
    );
  }
}