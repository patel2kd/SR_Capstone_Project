import 'dart:convert';
import 'package:flutter_alarm/Home_page.dart';
import 'package:flutter_alarm/app/data/models/alarm_detail.dart';
import 'package:flutter_alarm/app/data/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../alarm_helper.dart';
import '../../../utils/constants.dart';

List<AlarmDetail> alarmdetail = [];
late int nid = 0;
AlarmHelper _alarmHelper = AlarmHelper();

// class alarm_detailpage extends StatefulWidget {
class alarm_detailpage extends StatelessWidget {
  late final int params;
  alarm_detailpage(int params) {
    this.params = params;
    print("nid ${nid}");
    alarmdetail = [];
    nid = params;
    print("nid ${nid}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              toolbarTextStyle: TextStyle(fontWeight: FontWeight.bold),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Color(0xFF2565CC)),
          primaryColor: colorBlue,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('Alarm Detail')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      color: colorBlue,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: CustomColors.clockBG,
                            ),
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: "Your Task"
                                                  .text
                                                  .white
                                                  .xl2
                                                  .bold
                                                  .make(),
                                            ),
                                          ),
                                          Expanded(child: gesturedet()),
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 10),
              Expanded(
                flex: 5,
                child: Container(
                  child: alarm_list(),
                ),
              )
            ],
          ),
        ));
  }
}

class gesturedet extends StatefulWidget {
  const gesturedet({super.key});

  @override
  State<gesturedet> createState() => _gesturedetState();
}

class _gesturedetState extends State<gesturedet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            onTap: (() {
              setState(() {
                showdeleteall(nid);
              });
            }),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Column(children: [
                IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () {}),
                "Remove All".text.white.make()
              ]),
            )));
  }

  showdeleteall(int? nid) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: colorBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                'Are you sure you want to delete Task!',
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
                              alarmdetail = [];
                              _alarmHelper.deletedetail(nid);
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
}

class alarm_list extends StatefulWidget {
  const alarm_list({super.key});

  @override
  State<alarm_list> createState() => _alarm_listState();
}

class _alarm_listState extends State<alarm_list> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAlarmsDetail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: alarmdetail.length,
            itemBuilder: (context, index) {
              print(index);
              return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 226, 226),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 68.0, // shadow blur
                                    color: Color.fromARGB(
                                        255, 76, 74, 74), // shadow color
                                    offset: Offset(
                                        2.0, 2.0), //  fontFamily: 'avenir',
                                  ),
                                ],
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w500,
                                color: CustomColors.clockBG,
                                fontSize: 16),
                          ),
                          Text(
                            'Task',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 68.0, // shadow blur
                                    color: Color.fromARGB(
                                        255, 76, 74, 74), // shadow color
                                    offset: Offset(
                                        2.0, 2.0), //  fontFamily: 'avenir',
                                  ),
                                ],
                                fontFamily: 'avenir',
                                fontWeight: FontWeight.w500,
                                color: CustomColors.clockBG,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "${alarmdetail[index].date.toString().split('.').first}"
                              .text
                              .medium
                              .color(colorBlue)
                              .make(),
                          alarmdetail[index].status == 0
                              ? "Missing"
                                  .text
                                  .bold
                                  .xl
                                  .color(Color.fromARGB(255, 192, 10, 10))
                                  .make()
                              : "Complete"
                                  .text
                                  .bold
                                  .xl
                                  .color(Color.fromARGB(255, 7, 192, 13))
                                  .make()
                        ],
                      ),
                    ],
                  ));
            },
          );
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

Future<List<AlarmDetail>> getAlarmsDetail() async {
  print("alarm detailas");
  alarmdetail = [];
  final String path =
      '${url}alarm_detail.php?email_ref=${storage.getItem("email")}';
  print(path);
  final response = await http.get(Uri.parse(path));
  if (response.body.isNotEmpty) {
    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body.toString());

      for (Map<String, dynamic> element in result) {
        var alarmInfo = AlarmDetail.fromMap(element);
        if (alarmInfo.alarmId == nid) {
          alarmdetail.add(alarmInfo);
        }
        print(element);
      }
    }
  }
  return alarmdetail;
}
