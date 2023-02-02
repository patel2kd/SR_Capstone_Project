import 'dart:convert';
import 'package:flutter_alarm/app/data/models/alarm_detail.dart';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_alarm/app/data/models/alarm_info.dart';
import 'package:localstorage/localstorage.dart';

LocalStorage storage = new LocalStorage('localstorage_app');
late var email = storage.getItem("email");

class AlarmHelper {
  static AlarmHelper? _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper!;
  }

//Get all Insert Alarms

  void insertAlarm(AlarmInfo alarmInfo) async {
    print("Insert alarms ${email}");
    var url = Uri.http("${ipadd}", "${inseralarms}", {'q': '{http}'});
    await http.post(url, body: {
      "email": "${email}",
      "title": '${alarmInfo.title}',
      "description": '${alarmInfo.description}',
      "alarmDateTime": '${alarmInfo.alarmDateTime}',
      "isPending": '${alarmInfo.isPending}',
      "isActive": '${alarmInfo.isActive}',
      "isOn": '${alarmInfo.isOn}',
      "gradientColorIndex": '${alarmInfo.gradientColorIndex}',
      "nid": '${alarmInfo.nid}',
      "ison": '1',
    });
  }
//Get all alarm

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    final String path = '${url}alarm.php?email_ref=${email}';
    final response = await http.get(Uri.parse(path));
    var result = jsonDecode(response.body.toString());
    for (Map<String, dynamic> element in result) {
      var alarmInfo = AlarmInfo.fromMap(element);
      if (alarmInfo.isActive == 1) {
        _alarms.add(alarmInfo);
      }
      // print(element);
    }

    return _alarms;
  }

  Future<List<AlarmInfo>> getdeleteAlarms() async {
    List<AlarmInfo> _alarms = [];
    final String path = '${url}alarm.php?email_ref=${storage.getItem("email")}';
    // print(path);
    final response = await http.get(Uri.parse(path));
    // print(response.body);
    var result = jsonDecode(response.body.toString());
    for (Map<String, dynamic> element in result) {
      var alarmInfo = AlarmInfo.fromMap(element);
      if (alarmInfo.isActive == 0 && alarmInfo.title != 'titledemo') {
        _alarms.add(alarmInfo);
      }
      // print(element);
    }

    return _alarms;
  }
//Get all alarmDetails

  Future<List<AlarmDetail>> getAlarmsDetail() async {
    List<AlarmDetail> _alarmdetail = [];
    final String path = '${url}alarm_detail.php?email_ref=${email}';
    // print(path);
    final response = await http.get(Uri.parse(path));
    // print(response.body);
    var result = jsonDecode(response.body.toString());
    for (Map<String, dynamic> element in result) {
      var alarmInfo = AlarmDetail.fromMap(element);
      _alarmdetail.add(alarmInfo);
      // print(element);
    }
    return _alarmdetail;
  }

//delete alarm On/Off

  Future<int> updateisOn(int? nid, int? isOn) async {
    var url = Uri.http("${ipadd}", '${updatealarm}', {'q': '{http}'});
    if (isOn == 1) {
      await http.post(url, body: {
        "email": "${email}",
        "ison": '0',
        "nid": '${nid}',
      });
      int ret = 1;
      return ret;
    } else {
      await http.post(url, body: {
        "email": "${email}",
        "ison": '1',
        "nid": '${nid}',
      });
      int ret = 1;
      return ret;
    }
  }

//delete alarm isActive true/false

  Future<int> isdelete(int? id, int? isAcive) async {
    var url = Uri.http("${ipadd}", '${deletealarm}', {'q': '{http}'});
    if (isAcive == 1) {
      var response = await http.post(url,
          body: {"email": "${email}", "isactive": '0', "id": "${id}"});
      json.decode(response.body);

      int ret = 1;
      return ret;
    } else {
      await http.post(url,
          body: {"email": "${email}", "isactive": '1', "id": "${id}"});

      int ret = 1;
      return ret;
    }
  }

//delete alarm detail all tasks
  Future<int> deletedetail(int? nid) async {
    var url = Uri.http("${ipadd}", '${deletedetails}', {'q': '{http}'});

    await http.post(url, body: {"email": "${email}", "nid": "${nid}"});
    // print("delete data");
    // print(data);
    int ret = 1;
    return ret;
  }

  Future<int> deleteHistory() async {
    var url = Uri.http("${ipadd}", '${deletehistory}', {'q': '{http}'});
    await http.post(url, body: {"email": "${email}"});
    int ret = 1;
    return ret;
  }
}
