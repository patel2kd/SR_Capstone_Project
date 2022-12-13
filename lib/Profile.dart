import 'package:alertmind/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localstorage/localstorage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'app/modules/views/alarm_helper.dart';
import 'utils/constants.dart';

LocalStorage storage = new LocalStorage('localstorage_app');
var alrms = AlarmHelper().getAlarms();

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
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Name : ".text.white.bold.xl.make(),
                      "${storage.getItem("name")}".text.white.bold.xl.make(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Email : ".text.white.bold.xl.make(),
                      "${storage.getItem("email")}".text.white.bold.xl.make(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Emergency Email : ".text.white.bold.xl.make(),
                      "${storage.getItem("eemail")}".text.white.bold.xl.make(),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 25),
                    child: ElevatedButton(
                      child: Text(
                        'Log Out',
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 240, 19, 19),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          animationDuration: Duration(seconds: 1)),
                      onPressed: () {
                        LocalStorage storage =
                            new LocalStorage('localstorage_app');
                        storage.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
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
