// To parse this JSON data, do
//
//     final alarmDetail = alarmDetailFromMap(jsonString);

import 'dart:convert';

AlarmDetail alarmDetailFromMap(String str) =>
    AlarmDetail.fromMap(json.decode(str));

String alarmDetailToMap(AlarmDetail data) => json.encode(data.toMap());

class AlarmDetail {
  AlarmDetail({
    this.id,
    this.emailRef,
    this.alarmId,
    this.status,
    this.date,
  });

  int? id;
  String? emailRef;
  int? alarmId;
  int? status;
  DateTime? date;

  factory AlarmDetail.fromMap(Map<String, dynamic> json) => AlarmDetail(
        id: int.parse(json["id"] == null ? null : json["id"]),
        emailRef: json["email_ref"] == null ? null : json["email_ref"],
        alarmId: int.parse(json["alarm_id"] == null ? null : json["alarm_id"]),
        status: int.parse(json["status"] == null ? null : json["status"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "email_ref": emailRef == null ? null : emailRef,
        "alarm_id": alarmId == null ? null : alarmId,
        "status": status == null ? null : status,
        "date": date == null ? null : date.toString(),
      };
}
