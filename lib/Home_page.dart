//done
import 'package:alertmind/app/modules/views/alarm_page.dart';
import 'package:alertmind/app/modules/views/clock_page.dart';
import 'package:alertmind/app/modules/views/homepage.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:alertmind/Dashbord.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Profile.dart';

int _page = 2;
Page() {
  if (_page == 0) {
    return Dashbord();
  } else if (_page == 2) {
    return ClockPage();
  } else if (_page == 1) {
    return Profile();
  }
}

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        body: Page(),
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: BottomAppBar(
            elevation: 33,
            color: colorBlue,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Iconsax.home,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _page = 0;
                    });
                  },
                ),
                const SizedBox(width: 48.0),
                IconButton(
                  icon: const Icon(
                    Iconsax.user,
                    size: 25,
                    shadows: [Shadow(color: Colors.black)],
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _page = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorGrey,
          elevation: 22,
          onPressed: () {
            setState(() {
              _page = 2;
            });
          },
          child: Image.asset(
            'lib/images/sclock.png',
            width: 35,
            height: 35,
          ),
        ));
  }
}
