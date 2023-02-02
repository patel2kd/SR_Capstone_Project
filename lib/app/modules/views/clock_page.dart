import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/app/data/theme_data.dart';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:intl/intl.dart';

import 'clockview.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

    return Scaffold(
      appBar: AppBar(title: Text("Clock")),
      backgroundColor: colorbBlue,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DigitalClockWidget(),
                  Text(
                    formattedDate,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 68.0, // shadow blur
                            color: colorBlue, // shadow color
                            offset: Offset(2.0, 2.0), //  fontFamily: 'avenir',
                          ),
                        ],
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w300,
                        color: CustomColors.clockBG,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: ClockView(
                  size: MediaQuery.of(context).size.height / 3,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Timezone',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w500,
                        color: CustomColors.clockBG,
                        fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.language,
                        color: CustomColors.clockBG,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'UTC' + offsetSign + timezoneString,
                        style: TextStyle(
                            fontFamily: 'avenir',
                            color: CustomColors.clockBG,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var perviousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('=====>digital clock updated');
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Text(
        formattedTime,
        style: TextStyle(
          shadows: [
            Shadow(
              blurRadius: 10.0, // shadow blur
              color: colorBlue, // shadow color
              offset: Offset(2.0, 2.0), //  fontFamily: 'avenir',
            ),
          ],
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 64,
        ),
      ),
    );
  }
}
