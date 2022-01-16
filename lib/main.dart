import 'package:equalis/data/profile.dart';
import 'package:equalis/home/home.dart';
import 'package:equalis/setup/passport.dart';
import 'package:equalis/setup/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        primarySwatch: Colors.blue,
        highlightColor: const Color.fromRGBO(5, 232, 120, 1),
        errorColor: const Color.fromRGBO(240, 30, 30, 1),
        textTheme: TextTheme(
          headline1: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 38.0
          ),
          headline2: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 30.0
          ),
          subtitle1: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20.0
          ),
          subtitle2: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: Colors.grey,
            fontSize: 15.0
          ),
          bodyText2: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontSize: 15.0
          ),
        )
      ),
      home: FutureBuilder(
        future: Profile.checkAlreadyVerified(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data ?? false) ? Home() : Welcome();
          }
          // return Profile.verified ? Home() : Welcome();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator())
          );
        }
      ),
    );
  }
}