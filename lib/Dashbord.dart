import 'dart:ui';
import 'package:alertmind/app/modules/views/alarm_helper.dart';
import 'package:alertmind/app/modules/views/alarm_page.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:alertmind/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localstorage/localstorage.dart';

LocalStorage storage = new LocalStorage('localstorage_app');
final name = storage.getItem('name');

class Dashbord extends StatefulWidget {
  Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbBlue,
      appBar: AppBar(
        title: Text("Alarms "),
        backgroundColor: colorBlue, //background color of app bar
      ),
      body: Container(
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 25),
                        child: Row(children: [
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'Hello , 👋'.text.bold.xl4.white.make(),
                                '${storage.getItem("name")}'
                                    .text
                                    .xl4
                                    .white
                                    .bold
                                    .make(),
                              ],
                            ),
                          )),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ]),
            Expanded(
              child: Container(
                child: AlarmPage(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
