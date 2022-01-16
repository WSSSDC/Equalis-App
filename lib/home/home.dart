import 'package:equalis/data/profile.dart';
import 'package:equalis/elements/rounded_rect.dart';
import 'package:equalis/home/Laws.dart';
import 'package:equalis/home/election.dart';
import 'package:equalis/home/home_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  bool transitioning = false;

  static var _opacityTween = Tween<double>(begin: 1, end: 0);
  static var _opacityTween2 = Tween<double>(begin: 0, end: 1);
  static var _offsetTween = Tween<Offset>(begin: const Offset(0,0), end: const Offset(-500, 0));
  static var _offsetTween2 = Tween<Offset>(begin: const Offset(500,0), end: const Offset(0, 0));

  @override
  void initState() {
    // initData();
    controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addListener(() { setState(() {}); });
    super.initState();
  }

  initData() async {
    await Profile.init();
    setState((){});
  }

  int currentPage = 0;
  int nextPage = 0;

  setPage(int newPage) async {
    if (newPage > currentPage) {
      _offsetTween = Tween<Offset>(begin: const Offset(0,0), end: const Offset(-500, 0));
      _offsetTween2 = Tween<Offset>(begin: const Offset(500,0), end: const Offset(0, 0));
    } else if (newPage < currentPage) {
      _offsetTween = Tween<Offset>(begin: const Offset(0,0), end: const Offset(500, 0));
      _offsetTween2 = Tween<Offset>(begin: const Offset(-500,0), end: const Offset(0, 0));
    } else {
      return;
    }

    controller.reset();
    controller.forward();

    transitioning = true;
    
    setState(() => nextPage = newPage);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      transitioning = false;
      currentPage = newPage;
    });
  }

  Widget pageWidget(int _page) {
    switch (_page) {
      case 0:
        return const HomePage();
      case 1:
        return const Election();
      case 2:
        return const Laws();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: (transitioning ? <Widget>[
          Transform.translate(
            offset: _offsetTween.evaluate(animation),
            child: Opacity(
              opacity: _opacityTween.evaluate(animation),
              child: pageWidget(currentPage)
            )
          ),
          Transform.translate(
            offset: _offsetTween2.evaluate(animation),
            child: Opacity(
              opacity: _opacityTween2.evaluate(animation),
              child: pageWidget(nextPage)
            )
          ),
        ] :  <Widget>[pageWidget(nextPage)]) +  <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector (
                    onTap: () => setPage(0),
                    child: Opacity(
                      opacity: nextPage == 0 ? 1 : 0.3,
                      child: const Icon(Icons.home, size: 32.0,)
                    )
                  ),
                  GestureDetector (
                    onTap: () => setPage(1), 
                    child: Opacity(
                      opacity: nextPage == 1 ? 1 : 0.3,
                      child: const Icon(Icons.ballot, size: 32.0,)
                    )
                  ),
                  GestureDetector (
                    onTap: () => setPage(2),
                    child: Opacity(
                      opacity: nextPage == 2 ? 1 : 0.3,
                      child: const Icon(Icons.account_balance, size: 32.0,)
                    )
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}