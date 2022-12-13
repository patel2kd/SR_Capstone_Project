import 'package:alertmind/Dashbord.dart';
import 'package:alertmind/main.dart';
import 'app/modules/views/alarm_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alertmind/Login.dart';
import 'package:alertmind/utils/constants.dart';
import 'package:alertmind/Home_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/data/enums.dart';
import 'app/data/models/menu_info.dart';
import 'app/modules/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: colorBlue,
        systemNavigationBarColor: colorBlue,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(MyApp(''));
}

late String ss = '';

class MyApp extends StatefulWidget {
  final LocalStorage storage = new LocalStorage('localstorage_app');

  late final String params;
  MyApp(String params) {
    this.params = params;
    if (params == storage.getItem('email')) {
      ss = params;
    }
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      if (storage.getItem('email') != '') {
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
