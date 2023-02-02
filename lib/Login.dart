// import 'package:flutter_alarm/fetchdata.dart';
import 'package:flutter_alarm/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:flutter_alarm/widgets/registertitle.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localstorage/localstorage.dart';

var user = [];
@override
fetchuser() async {
  final String path = '${url}${index}';
  print(path);
  var response = await http.get(Uri.parse(path));
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    user = data;
    print("data ${data}");
    return user;
  } else {
    print("data ");
    print(response.body);
    return user;
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
//Text Controllers
  LocalStorage storage = new LocalStorage('localstorage_app');
  TextEditingController Name = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController rEmail = new TextEditingController();
  TextEditingController eEmail = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController econtact = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController rpassword = new TextEditingController();
//initial variables
  bool processing = false;
  late String getData;
  bool validate = false;
  bool validate1 = false;
  late String merror = '';
  late String emerror = '';
  late String eerror = '';
  late String perror = '';
  late String nerror = '';
  late String xluser = '';
  late String reerror = '';
  late String eEerror = '';
  late String cerror = '';
  late String eCerror = '';
  late String rperror = '';

  //Singup form
  void initState() {
    fetchuser();
    print(user);
    super.initState();
  }

  Widget SingUp() {
    return Expanded(
        flex: 8,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: 'Sign Up'
                      .text
                      .fontWeight(FontWeight.bold)
                      .xl3
                      .white
                      .make(),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                  child: '$merror'
                      .text
                      .align(TextAlign.justify)
                      .red400
                      .medium
                      .maxFontSize(12)
                      .minFontSize(10)
                      .make(),
                ),
                Container(
                  width: 315,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 235, 235),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  nerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  nerror;
                                }),
                              }
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: 'Enter Name',
                            errorText: nerror,
                          ),
                          controller: Name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  reerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  reerror = '';
                                  if (!value.contains('gmail.com')) {
                                    reerror = 'Email not valid';
                                    setState(() {
                                      validate1 = false;
                                    });
                                  } else {
                                    reerror = '';
                                  }
                                }),
                              }
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: 'Enter Email',
                            errorText: reerror,
                          ),
                          controller: rEmail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  cerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  cerror = '';
                                }),
                              }
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: '+1(xxx)xxx-xxxx',
                            errorText: cerror,
                          ),
                          controller: contact,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  eEerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  eEerror = '';
                                  if (!value.contains('.com')) {
                                    eEerror = 'Email not valid';
                                    setState(() {
                                      validate1 = false;
                                    });
                                  } else {
                                    eEerror = '';
                                  }
                                }),
                              }
                          },
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: 'Emergency Email',
                            errorText: eEerror,
                          ),
                          controller: eEmail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  eCerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  eCerror = '';
                                }),
                              }
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: '+1(xxx)xxx-xxxx',
                            errorText: eCerror,
                          ),
                          controller: econtact,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate1 = false;
                                  rperror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate1 = true;
                                  rperror = '';
                                  if (value.length <= 8) {
                                    rperror = 'password not valid';
                                    setState(() {
                                      validate1 = false;
                                    });
                                  } else {
                                    rperror = '';
                                  }
                                }),
                              }
                          },
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            hintText: 'Enter Password',
                            errorText: rperror,
                          ),
                          controller: rpassword,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //SingIn form

  Widget SingIn() {
    return Expanded(
        flex: 8,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: 'Sign In'
                      .text
                      .fontWeight(FontWeight.bold)
                      .xl3
                      .white
                      .make(),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                  child: '$emerror'
                      .text
                      .align(TextAlign.justify)
                      .red400
                      .medium
                      .maxFontSize(12)
                      .minFontSize(10)
                      .make(),
                ),
                Container(
                  width: 315,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 235, 235),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate = false;
                                  eerror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate = true;
                                  eerror = '';
                                  if (!value.contains('.com')) {
                                    eerror = 'Email not valid';
                                    setState(() {
                                      validate = false;
                                    });
                                  } else {
                                    eerror = '';
                                  }
                                }),
                              }
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.white),
                            hintText: 'Enter Email',
                            errorText: eerror,
                          ),
                          controller: Email,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          onChanged: (value) => {
                            if (value.isEmpty)
                              {
                                setState(() {
                                  validate = false;
                                  perror = 'Plese fill';
                                }),
                              }
                            else
                              {
                                setState(() {
                                  validate = true;
                                  perror = '';
                                  if (value.length <= 8) {
                                    perror = 'password not valid';
                                    setState(() {
                                      validate = false;
                                    });
                                  } else {
                                    perror = '';
                                  }
                                }),
                              }
                          },
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Color(0xfffaebeb),
                            contentPadding: EdgeInsets.all(12),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Color(0xff3F8AE0)),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: colorBlue),
                            ),
                            disabledBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            hintText: 'Enter Password',
                            errorText: perror,
                          ),
                          controller: password,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

//Boxui Tab navigation Sign Up to sing in
  int TabId = 2;
  String TabTitle = 'Sign Up';
  bool Tabsing = true;
  void changestate() {
    if (TabId % 2 == 0) {
      Tabsing = false;
      TabTitle = 'Sign In';
      TabId += 1;
    } else {
      Tabsing = true;
      TabId += 1;
      TabTitle = 'Sign Up';
    }
  }

//Box ui
  Widget BoxUi() {
    return Expanded(
        flex: 2,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 34, 34, 34),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            setState(() {
                              changestate();
                            });
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => Register()));
                          },
                          child: "$TabTitle"
                              .text
                              .shadow(2, 2, 23, Color.fromARGB(105, 61, 61, 61))
                              .xl3
                              .make()),
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 240, 89, 19),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            Tabsing ? Login() : Register();
                          },
                          child: processing == false
                              ? 'Submit'.text.xl3.make()
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                )),
                    )),
              )
            ],
          ),
        ));
  }

//Main Login Widget

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorBlue,
      body: Column(
        children: [registertitle(), Tabsing ? SingIn() : SingUp(), BoxUi()],
      ),
    );
  }

//register param function
  setLogin() async {
    for (int i = 0; i < user.length; i++) {
      if (user[i]["email"] == Email.text.toString()) {
        var email = user[i]["email"];
        var Name = user[i]["Name"];
        var eemail = user[i]["eemail"];
        var number = user[i]["econtact"];
        storage.setItem("email", email.toString());
        storage.setItem("name", Name.toString());
        storage.setItem("eemail", eemail.toString());
        storage.setItem("number", number.toString());
      }
    }
  }

//Login function
  Login() async {
    var url = Uri.http("${ipadd}", '${login}', {'q': '{http}'});

    if (validate == true && perror == '' && eerror == '') {
      setState(() {
        emerror = '';
      });
      print("login start");
      var response = await http.post(url, body: {
        "email": Email.text.toString(),
        "password": password.text.toString(),
      });
      var data = json.decode(response.body);
      print("login start");
      print(response.body);
      if (data.toString() == "Success") {
        Fluttertoast.showToast(
          msg: 'Login Successful',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        setState(() {
          setLogin();
        });

        var ee = storage.getItem("email");
        print("email is ${ee}");
        if (ee != null) {
          MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/', (route) => false,
              arguments: Email.text.toString());
        }
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'Username and password invalid',
          toastLength: Toast.LENGTH_SHORT,
        );
        setState(() {
          emerror = 'Email or password wrong';
        });
      }
    } else {
      setState(() {
        emerror = 'please fill Properly';
      });
    }
  }

//register param function
  setRegister() {
    storage.setItem("email", rEmail.text.toString());
    storage.setItem("eemail", eEmail.text.toString());
    storage.setItem("name", Name.text.toString());
    storage.setItem("number", econtact.text.toString());
  }

//register function
  Register() async {
    if (validate1 == true) {
      setState(() {
        merror = '';
      });
      var url = Uri.http("${ipadd}", '${register}', {'q': '{https}'});
      var response = await http.post(url, body: {
        "email": rEmail.text.toString(),
        "Name": Name.text.toString(),
        "eemail": eEmail.text.toString(),
        "contact": contact.text.toString(),
        "econtact": econtact.text.toString(),
        "password": rpassword.text.toString(),
      });
      var data = json.decode(response.body);
      print(data);
      print('data');
      if (data == "Success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Registration Successful',
          toastLength: Toast.LENGTH_SHORT,
        );
        setState(() {
          setRegister();
          merror = 'please fill Properly';
        });
        MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            '/', (route) => false,
            arguments: rEmail.text.toString());
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          msg: 'User already registerd!',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      setState(() {
        merror = 'please fill Properly';
      });
    }
  }
}
