import 'package:flutter_alarm/app/data/models/alarm_info.dart';

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      description: '2',
      nid: 2,
      isActive: 1,
      isOn: 1,
      isPending: 1,
      gradientColorIndex: 0),
];
