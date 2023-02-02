import 'dart:convert';
import 'package:flutter_alarm/Home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:velocity_x/velocity_x.dart';

import 'app/data/models/alarm_info.dart';
import 'mainscreen.dart';

LocalStorage storage = new LocalStorage('localstorage_app');

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.receivedAction})
      : super(key: key);

  final ReceivedAction receivedAction;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  void comp() async {
    await executeLongTaskInBackground2(widget.receivedAction.id, 1);
  }

  void miss() async {
    await executeLongTaskInBackground2(widget.receivedAction.id, 0);
  }

  executeLongTaskInBackground2(int? id, int? status) async {
    DateTime date = DateTime.now();
    LocalStorage storage = new LocalStorage('localstorage_app');

    late String email = storage.getItem("email");
    late String eemail = storage.getItem("eemail");
    late String number = storage.getItem("number");
    late String name = storage.getItem("name");

    final url = Uri.http("${ipadd}", '${updatealarm}', {'q': '{http}'});
    var response = await http.post(url, body: {
      "email": "${email}",
      "isOn": '0',
      "nid": "${id}",
    });
    print(response.body);
    var data = jsonDecode(response.body.toString());
    if (data == "1") {
      print("repete alarm stating");
      final url2 = Uri.http("${ipadd}", '${repetealarm}', {'q': '{http}'});
      var response2 = await http.post(url2, body: {
        "email": "${email}",
        "nid": "${id}",
      });
      var res = jsonDecode(response2.body);
      print(res);

      if (res != null) {
        print("Delay start");
        Future.delayed(Duration(minutes: 1), () {
          print("after 40 second");
          for (Map<String, dynamic> element in res) {
            var alarmInfo = AlarmInfo.fromMap(element);
            NotificationController.createNewNotification(alarmInfo);
          }
        });
      }
    }

    final url2 = Uri.http("${ipadd}", '${inseralarmdetail}', {'q': '{http}'});
    print(url2);

    await http.post(url2, body: {
      "email": "${email}",
      "name": "${name}",
      "eemail": "${eemail}",
      "number": "${number}",
      "id": "${id}",
      "status": "${status}",
      "date": "${date}",
      "mail": "mail"
    });
  }

// LocalStorage storage = new LocalStorage('localstorage_app');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Page"),
        elevation: 0,
        backgroundColor: colorBlue, //background color of app bar
      ),
      body: Column(
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
                  child: Row(children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0, color: colorbBlue),
                                  ],
                                  borderRadius: BorderRadius.circular(24),
                                  color: colorbBlue,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 6, top: 6),
                                  child: Column(
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        if (widget.receivedAction.title
                                                ?.isNotEmpty ??
                                            false)
                                          TextSpan(
                                            text:
                                                'Task Name :- ${widget.receivedAction.title}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        if ((widget.receivedAction.title
                                                    ?.isNotEmpty ??
                                                false) &&
                                            (widget.receivedAction.body
                                                    ?.isNotEmpty ??
                                                false))
                                          TextSpan(
                                            text: '\n\n',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        if (widget.receivedAction.body
                                                ?.isNotEmpty ??
                                            false)
                                          TextSpan(
                                            text:
                                                'Description :- ${widget.receivedAction.body}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                      ])),
                                    ],
                                  ),
                                ),
                              ),
                            ])))
                  ]))),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Image.asset(
                'lib/images/clock.gif',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              comp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_page()),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 34, 34, 34),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          child: Row(children: [
                            IconButton(
                                icon: Icon(Icons.done),
                                color: Color.fromARGB(255, 7, 209, 0),
                                onPressed: () {
                                  setState(() {
                                    comp();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home_page()),
                                    );
                                  });
                                }),
                            "Cicked to Task Complete! ".text.make()
                          ]),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              miss();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home_page()),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 34, 34, 34),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          child: Row(children: [
                            IconButton(
                                icon: Icon(Icons.close),
                                color: Color.fromARGB(255, 209, 0, 0),
                                onPressed: () {
                                  setState(() {
                                    miss();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home_page()),
                                    );
                                  });
                                }),
                            "Cicked to Task Missing! ".text.make()
                          ]),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
