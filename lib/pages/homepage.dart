import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'feeds.dart';
import 'events_page.dart';
import 'profile.dart';
import 'search.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String routeName = '/home_screen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 0;
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: PageView(
        controller: pageController,
        onPageChanged: navigationTapped,
        children:  [
          Feeds(),
          Search(),
          Search(),
          Events(),
          Profile()
        ],

      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        currentIndex: _page,
        onTap: onTap,
        activeColor: Theme.of(context).accentColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled_solid,size: 40,),),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.message,size: 25,),),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid),),
        ],
      ),
    );
  }
  void onTap(int page){
    pageController!.animateToPage(
        page,
        duration:const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn
    );
  }
  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
