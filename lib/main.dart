import 'package:flutter/material.dart';
import 'package:flutter_alarm/Home_page.dart';
import 'package:flutter_alarm/Login.dart';
import 'mainscreen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'utils/constants.dart';

LocalStorage storage = new LocalStorage('localstorage_app');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: colorBlue,
        systemNavigationBarColor: colorBlue,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(MyApp());
}

late String ss =
    storage.getItem("email") == null ? '' : storage.getItem("email");

class MyApp1 extends StatefulWidget {
  late final String params;
  MyApp1(String params) {
    this.params = params;
    if (params == storage.getItem('email')) {
      ss = params;
    }
  }

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
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
      home: AnimatedSplashScreen(
          duration: 100,
          splashIconSize: 230,
          splash: Column(
            children: [
              Image.asset('lib/images/sclock.png'),
              SizedBox(
                height: 20,
              ),
              'Alertmind App'.text.bold.color(Colors.white70).xl2.make(),
            ],
          ),
          nextScreen: Main(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final LocalStorage storage = new LocalStorage('localstorage_app');

  Both() {
    if (ss == '') {
      if (storage.getItem('email') == null) {
        return Login();
      } else {
        return Home_page();
      }
    } else {
      return Home_page();
    }
  }

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
      home: Both(),
    );
  }
}
