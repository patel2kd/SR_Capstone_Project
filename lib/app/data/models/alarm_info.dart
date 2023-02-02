class AlarmInfo {
  int? id;
  String? email_ref;
  String? title;
  String? description;
  DateTime? alarmDateTime;
  int? isActive;
  int? isOn;
  int? isPending;
  int? gradientColorIndex;
  int? nid;

  AlarmInfo(
      {this.id,
      this.email_ref,
      this.title,
      this.description,
      this.alarmDateTime,
      this.isActive,
      this.isOn,
      this.isPending,
      this.gradientColorIndex,
      this.nid});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: int.parse(json["id"]),
        email_ref: json["email_ref"],
        title: json["title"],
        description: json["description"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        isPending: int.parse(json["isPending"]),
        isActive: int.parse(json["isActive"]),
        isOn: int.parse(json["isOn"]),
        gradientColorIndex: int.parse(json["gradientColorIndex"]),
        nid: int.parse(json["nid"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "email_ref": email_ref,
        "title": title,
        "description": description,
        "alarmDateTime": alarmDateTime!.toIso8601String(),
        "isPending": isPending,
        "isActive": isActive,
        "isOn": isOn,
        "gradientColorIndex": gradientColorIndex,
        "nid": nid,
      };
}
