import 'package:flutter_alarm/app/modules/views/clock_page.dart';
import 'package:flutter_alarm/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'Profile.dart';

int _page = 2;
Page() {
  if (_page == 0) {
    return AlarmPage();
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
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 0.4,
            centerTitle: true,
            backgroundColor: Color(0xFF2565CC)),
        primaryColor: colorBlue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      title: '',
      home: Scaffold(
          backgroundColor: colorbBlue,
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: colorDarkBlue,
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
          )),
    );
  }
}
