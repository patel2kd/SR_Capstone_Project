import 'package:flutter_alarm/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/app/data/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Home_page.dart';
import 'alarm_helper.dart';
import 'app/data/models/alarm_info.dart';
import 'mainscreen.dart';
import 'utils/constants.dart';

LocalStorage storage = new LocalStorage('localstorage_app');
var alrms = AlarmHelper().getdeleteAlarms();

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile "),
        backgroundColor: colorBlue, //background color of app bar
      ),
      body: Container(
        color: colorbBlue,
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Name : ".text.white.bold.xl.make(),
                          Expanded(
                              child: Center(
                                  child: "${storage.getItem("name")}"
                                      .text
                                      .bold
                                      .color(colorbBlue)
                                      .xl
                                      .make())),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          "Email : ".text.white.bold.xl.make(),
                          Expanded(
                              child: Center(
                            child: "${storage.getItem("email")}"
                                .text
                                .color(colorbBlue)
                                .bold
                                .xl
                                .make(),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          "Emg Email : ".text.white.bold.xl.make(),
                          Expanded(
                              child: Center(
                                  child: "${storage.getItem("eemail")}"
                                      .text
                                      .color(colorbBlue)
                                      .bold
                                      .xl
                                      .make())),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          "Number : ".text.white.bold.xl.make(),
                          Expanded(
                              child: Center(
                                  child: "${storage.getItem("number")}"
                                      .text
                                      .color(colorbBlue)
                                      .bold
                                      .xl
                                      .make())),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 0, right: 0, top: 20),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Log Out',
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 240, 19, 19),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                animationDuration: Duration(seconds: 1)),
                            onPressed: () {
                              storage.clear();
                              NotificationController.cancelNotifications;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 0, right: 0, top: 20),
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'View History',
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.clockBG,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                animationDuration: Duration(seconds: 1)),
                            onPressed: () {
                              MyApp.navigatorKey.currentState
                                  ?.pushNamedAndRemoveUntil(
                                '/viewhistory',
                                (route) =>
                                    (route.settings.name != '/viewhistory') ||
                                    route.isFirst,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class ViewHistory extends StatefulWidget {
  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  TextEditingController titlecntr = new TextEditingController();
  TextEditingController discntr = new TextEditingController();

  @override
  void initState() {
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getdeleteAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 0.4,
            centerTitle: true,
            backgroundColor: Color(0xFF2565CC)),
        primaryColor: colorBlue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Deleted Alarm')),
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red,
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Remove All".text.white.make(),
                            IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    showhistorydelete();
                                    // _alarmHelper.deleteHistory();
                                    loadAlarms();
                                  });
                                }),
                          ],
                        ),
                      )),
                )
              ]),
              Expanded(
                child: FutureBuilder<List<AlarmInfo>>(
                  future: _alarms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.map<Widget>((alarm) {
                          var alarmTime = DateFormat('hh:mm aa')
                              .format(alarm.alarmDateTime!);
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex!]
                              .colors;
                          return GestureDetector(
                            onTap: () {
                              print("navigate");
                              print(alarm.nid);
                              MyApp.navigatorKey.currentState
                                  ?.pushNamedAndRemoveUntil(
                                '/alarmdetail',
                                (route) =>
                                    (route.settings.name != '/alarm-page') ||
                                    route.isFirst,
                                arguments: int.parse("${alarm.nid}"),
                              );

                              print("myappigate");
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 32),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColor,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: gradientColor.last.withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.label,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            alarm.title!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'avenir'),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                          onChanged: (value) {
                                            setState(() {
                                              loadAlarms();
                                            });
                                          },
                                          value:
                                              alarm.isOn == 1 ? true : false),
                                    ],
                                  ),
                                  Text(
                                    'Mon-Fri',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        alarmTime,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons
                                              .replay_circle_filled_rounded),
                                          color: Colors.white,
                                          onPressed: () {
                                            showrecover(alarm.id, alarm.nid,
                                                alarm.isActive);
                                            // recoverAlarm(alarm.id, alarm.nid,
                                            // alarm.isActive);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Loading..',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showhistorydelete() {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: colorBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                'Are you sure you want to delete All Alarms ?',
                style: TextStyle(color: colorbBlue),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('Yes'),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            setState(() {
                              _alarmHelper.deleteHistory();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_page()),
                              );
                            });
                          }),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('No !'),
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                )
              ],
            ));
  }

  showrecover(int? id, int? Nid, int? isactive) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: colorBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                'Are you sure you want to recover this Alarms ?',
                style: TextStyle(color: colorbBlue),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('Yes'),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            setState(() {
                              recoverAlarm(id, Nid, isactive);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_page()),
                              );
                            });
                          }),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('No !'),
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                )
              ],
            ));
  }

  void recoverAlarm(int? id, int? Nid, int? isactive) async {
    print(id);
    print(Nid);
    _alarmHelper.isdelete(id, isactive);
    NotificationController.cancelNotifications(Nid);
    loadAlarms();
  }
}
