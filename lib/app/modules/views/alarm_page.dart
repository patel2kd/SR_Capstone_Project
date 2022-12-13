import 'dart:convert';
import 'package:alertmind/Profile.dart';
import 'package:alertmind/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:alertmind/app/modules/views/alarm_helper.dart';
import 'package:alertmind/app/data/theme_data.dart';
import 'package:alertmind/app/data/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cron/cron.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

LocalStorage storage = new LocalStorage('localstorage_app');

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
  TextEditingController titlecntr = new TextEditingController();
  var Cron1 = [];
  // Cron1 == null ? print("null list") : print("no");
  int cronid = 0;
  int crondelid = 0;
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                      var alarmTime =
                          DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex!].colors;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onChanged: (bool value) {
                                    _alarmHelper.delete(alarm.id);
                                    Cron c = Cron1.elementAt(alarm.id!);
                                    c.close();
                                    // Cron1.removeAt(Complete);
                                    FlutterAlarmClock.showAlarms();
                                    setState(() {
                                      loadAlarms();
                                    });
                                  },
                                  value: true,
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              'Mon-Fri',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'avenir'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      // setState(() {
                                      deleteAlarm(alarm.id);
                                      // });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentAlarms!.length < 5)
                        DottedBorder(
                          strokeWidth: 3,
                          color: Colors.grey,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(40),
                          dashPattern: [6, 4],
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: colorGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23, vertical: 10),
                                onPressed: () {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(DateTime.now());
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) {
                                          return Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    var selectedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (selectedTime != null) {
                                                      final now =
                                                          DateTime.now();
                                                      var selectedDateTime =
                                                          DateTime(
                                                              now.year,
                                                              now.month,
                                                              now.day,
                                                              selectedTime.hour,
                                                              selectedTime
                                                                  .minute);
                                                      _alarmTime =
                                                          selectedDateTime;
                                                      setModalState(() {
                                                        _alarmTimeString =
                                                            DateFormat('HH:mm')
                                                                .format(
                                                                    selectedDateTime);
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    _alarmTimeString,
                                                    style:
                                                        TextStyle(fontSize: 32),
                                                  ),
                                                ),
                                                TextField(
                                                    controller: titlecntr,
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons.note),
                                                        labelText:
                                                            "Enter Title")),
                                                SizedBox(height: 20),
                                                ListTile(
                                                  title: Text('Repeat'),
                                                  trailing: Switch(
                                                    onChanged: (value) {
                                                      setModalState(() {
                                                        _isRepeatSelected =
                                                            value;
                                                      });
                                                    },
                                                    value: _isRepeatSelected,
                                                  ),
                                                ),
                                                FloatingActionButton.extended(
                                                  onPressed: () {
                                                    onSaveAlarm(
                                                        _isRepeatSelected);
                                                  },
                                                  icon: Icon(Icons.alarm),
                                                  label: Text('Save'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                  // scheduleAlarm();
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/add_alarm.png',
                                      scale: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                            child: Text(
                          'Only 5 alarms allowed!',
                          style: TextStyle(color: Colors.white),
                        )),
                    ]).toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onSaveAlarm(bool _isRepeating) {
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: titlecntr.text.toString(),
    );
    _alarmHelper.insertAlarm(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      // scheduleAlarm(scheduleAlarmDateTime, alarmInfo,
      //     isRepeating: _isRepeating);
      setState(() {
        scheduleTask(scheduleAlarmDateTime!.hour, scheduleAlarmDateTime.minute,
            _isRepeating);
        loadAlarms();
      });

      crondelid = cronid;
      cronid += 1;
    }

    crondelid = cronid;
    cronid += 1;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profile()));
  }

//scheduletask if user add new Alarm

  void scheduleTask(int? hh, int? mm, bool? repete) async {
    FlutterAlarmClock.createAlarm(
      hh!,
      mm!,
      title: titlecntr.text.toString(),
    );
    print("Task Running");
    print("hour and minit ${hh} and ${mm}");

    mailfun(hh, mm);
    String date = "${mm} ${hh} * * *";

    var c1 = Cron();
    repete == true
        ? c1.schedule(Schedule.parse(date), () async {
            print("Executing task : " + DateTime.now().toString());
            print("Repete alarm");
            FlutterAlarmClock.createAlarm(
              hh,
              mm,
              title: titlecntr.text.toString(),
            );
            mailfun(hh, mm);
          })
        : c1.schedule(Schedule.parse(date), () async {
            print("Executing task : " + DateTime.now().toString());
            print('after del ${crondelid}');
            mailfun(hh, mm);

            setState(() {
              _alarmHelper.delete(crondelid);
              crondelid += 1;
            });
            _alarmHelper.delete(crondelid);
            // unsubscribe for notification
            print('del');
            Cron c = Cron1.elementAt(crondelid);
            c.close();
          });
    var cronlist = storage.getItem("cron");
    if (cronlist == null) {
      Cron1.add(c1);
    } else {
      Cron1.add(storage.getItem("cron"));
      Cron1.add(c1);
      storage.setItem("cron", Cron1);
    }
  }

//deelteAlaram from id and also cron
  void deleteAlarm(int? id) {
    print('del');
    _alarmHelper.delete(id);
    // unsubscribe for notification
    print('del');
    Cron c = Cron1.elementAt(id!);
    c.close();
    // Cron1.removeAt(Complete);
    setState(() {
      loadAlarms();
    });
    loadAlarms();
    FlutterAlarmClock.showAlarms();
  }

//Mail function to sent mail
  mailfun(int? Hour, int Minute) async {
    var eemail = storage.getItem("eemail");
    var name = storage.getItem("name");
    String subject = 'AlertMind';
    String message =
        'Hello , ${name} Your ${titlecntr.text.toString()} ${Hour}:${Minute} Alarm Are Trigger';
    print("data sennt mail proccesing");
    var url = Uri.http("192.168.231.146", '/demo/send_mail.php');
    print("data ${url}");
    var response = await http.post(url, body: {
      "eemail": eemail.toString(),
      "subject": subject.toString(),
      "message": message.toString(),
    });
    var data = json.decode(response.body);
    print("data ${response.body}");
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'Somting Wrong!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Mail Successful sent',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
