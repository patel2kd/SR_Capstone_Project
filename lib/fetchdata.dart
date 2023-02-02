import 'dart:convert';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:http/http.dart' as http;

var user = [];
@override
fetchuser() async {
  final response = await http.get(Uri.parse('${url}${index}'));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    user = data;
    print("data ${data}");
    return user;
  } else {
    return user;
  }
}
