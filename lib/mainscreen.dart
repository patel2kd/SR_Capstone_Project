import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm/Home_page.dart';
import 'package:flutter_alarm/Profile.dart';
import 'package:flutter_alarm/app/modules/views/alarm_detailpage.dart';
import 'package:flutter_alarm/main.dart';
import 'package:flutter_alarm/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_alarm/alarm_helper.dart';
import 'package:flutter_alarm/app/data/theme_data.dart';
import 'package:flutter_alarm/app/data/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'NotificationPage.dart';

LocalStorage storage = new LocalStorage('localstorage_app');
late var email = storage.getItem("email");

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'alerts',
              locked: false,
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              soundSource: 'resource://raw/a_long_cold_sting',
              playSound: true,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.Default) {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page', (Route) => false,
          arguments: receivedAction);
    }
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'lib/images/clock.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Allow Notifications to Alarm!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> createNewNotification(AlarmInfo alarmInfo) async {
    int NId = int.parse("${alarmInfo.nid}");
    var title = alarmInfo.title;
    var description = alarmInfo.description;
    int hh = alarmInfo.alarmDateTime!.hour;
    int mm = alarmInfo.alarmDateTime!.minute;

    alarmInfo.isOn;
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: int.parse("$NId"), // -1 is replaced by a random number
            channelKey: 'alerts',
            title: title,
            body: description,
            locked: false,
            largeIcon:
                'https://pixlok.com/wp-content/uploads/2021/07/Alarm-Clock-Icon-SVG-fdass.png',
            notificationLayout: NotificationLayout.BigText,
            payload: {'notificationId': NId.toString()}),
        actionButtons: [
          NotificationActionButton(
              key: 'REDIRECT',
              enabled: true,
              label: 'Redirect',
              actionType: ActionType.Default),
        ],
        schedule: NotificationCalendar(hour: hh, minute: mm, repeats: false));
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications(int? id) async {
    await AwesomeNotifications().cancel(int.parse("$id"));
  }
}

///  *********************************************
///     MAIN WIDGET
///  *********************************************
///
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // This widget is the root of your application.

  static const String routeHome = '/',
      routeNotification = '/notification-page',
      routAlarm = '/alarm-page',
      routmain = '/main1',
      routAlarmdetail = '/alarmdetail',
      routviewhistory = '/viewhistory';
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    getAlarmsDetail();
    super.initState();
  }

  List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
    List<Route<dynamic>> pageStack = [];
    if (NotificationController.initialAction == null) {
      pageStack.add(MaterialPageRoute(builder: (_) => MyApp1('')));
    } else if (NotificationController.initialAction!.actionType ==
        ActionType.SilentAction) {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController.initialAction!)));
    } else {
      pageStack.add(MaterialPageRoute(
          builder: (_) => NotificationPage(
              receivedAction: NotificationController.initialAction!)));
    }
    return pageStack;
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => Home_page());
      case routmain:
        return MaterialPageRoute(
            builder: (_) => MyApp1("${settings.arguments}"));
      case routAlarm:
        return MaterialPageRoute(builder: (_) => AlarmPage());
      case routviewhistory:
        return MaterialPageRoute(builder: (_) => ViewHistory());

      case routAlarmdetail:
        return MaterialPageRoute(
            builder: (_) =>
                alarm_detailpage(int.parse("${settings.arguments}")));

      case routeNotification:
        ReceivedAction receivedAction = settings.arguments as ReceivedAction;
        return MaterialPageRoute(
            builder: (_) => NotificationPage(receivedAction: receivedAction));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notifications - Simple Example',
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 0.4,
            centerTitle: true,
            backgroundColor: Color(0xFF2565CC)),
        primaryColor: colorBlue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
    );
  }
}

///  *********************************************
///     NOTIFICATION PAGE
///  *********************************************
class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;
  TextEditingController titlecntr = new TextEditingController();
  TextEditingController discntr = new TextEditingController();

  @override
  void initState() {
    _alarmTime = DateTime.now();
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            toolbarTextStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 0.4,
            centerTitle: true,
            backgroundColor: Color(0xFF2565CC)),
        primaryColor: colorBlue,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Alarms')),
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
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
                          var alarmTime = DateFormat('hh:mm aa')
                              .format(alarm.alarmDateTime!);
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex!]
                              .colors;
                          return GestureDetector(
                            onTap: () {
                              print("navigate");
                              print(alarm.nid);
                              MyApp.navigatorKey.currentState
                                  ?.pushNamedAndRemoveUntil(
                                '/alarmdetail',
                                (route) =>
                                    (route.settings.name != '/alarm-page') ||
                                    route.isFirst,
                                arguments: int.parse("${alarm.nid}"),
                              );

                              print("navigate");
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 32),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 4),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onChanged: (value) {
                                            setState(() {
                                              updateison(alarm);
                                              loadAlarms();
                                            });
                                          },
                                          value:
                                              alarm.isOn == 1 ? true : false),
                                    ],
                                  ),
                                  Text(
                                    'Mon-Fri',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onPressed: () async {
                                            await showdelete(alarm.id,
                                                alarm.nid, alarm.isActive);
                                            // deleteAlarm(alarm.id, alarm.nid,
                                            // alarm.isActive);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).followedBy([
                          if (_currentAlarms!.length < 21)
                            Container(
                              margin: EdgeInsets.only(bottom: 100),
                              child: DottedBorder(
                                strokeWidth: 2,
                                color: CustomColors.clockOutline,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(24),
                                dashPattern: [5, 4],
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: CustomColors.clockBG,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
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
                                                padding:
                                                    const EdgeInsets.all(32),
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
                                                        if (selectedTime !=
                                                            null) {
                                                          final now =
                                                              DateTime.now();
                                                          var selectedDateTime =
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day,
                                                                  selectedTime
                                                                      .hour,
                                                                  selectedTime
                                                                      .minute);
                                                          _alarmTime =
                                                              selectedDateTime;
                                                          setModalState(() {
                                                            _alarmTimeString =
                                                                DateFormat(
                                                                        'HH:mm')
                                                                    .format(
                                                                        selectedDateTime);
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        _alarmTimeString,
                                                        style: TextStyle(
                                                            fontSize: 32),
                                                      ),
                                                    ),
                                                    TextField(
                                                        controller: titlecntr,
                                                        decoration: InputDecoration(
                                                            icon: Icon(
                                                                Icons.note),
                                                            labelText:
                                                                "Add Medicine")),
                                                    SizedBox(height: 5),
                                                    TextField(
                                                        controller: discntr,
                                                        decoration: InputDecoration(
                                                            icon: Icon(
                                                                Icons.note),
                                                            labelText:
                                                                "Description")),
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
                                                        value:
                                                            _isRepeatSelected,
                                                      ),
                                                    ),
                                                    FloatingActionButton
                                                        .extended(
                                                      onPressed: () {
                                                        // _alarmHelper.Altertable();
                                                        if (titlecntr.text !=
                                                                '' &&
                                                            discntr.text != '')
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
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/add_alarm.png',
                                          scale: 1.5,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Add Medicine',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Column(
                              children: [
                                Center(
                                    child: Text(
                                  'Only 20 medicine can be added!',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                        ]).toList(),
                      );
                    }
                    return Center(
                      child: Text(
                        'Loading..',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showdelete(int? id, int? Nid, int? isactive) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: colorBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                'Are you sure you want to delete Alarm ?',
                style: TextStyle(color: colorbBlue),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('Yes'),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          onPressed: () {
                            deleteAlarm(id, Nid, isactive);
                          }),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70)),
                              animationDuration: Duration(seconds: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text('No !'),
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                )
              ],
            ));
  }

  void onSaveAlarm(bool _isRepeating) {
    print("onsave");
    print(_currentAlarms!.length);
    DateTime? scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));
    int hh = scheduleAlarmDateTime!.hour;
    int mm = scheduleAlarmDateTime.minute;
    int dd = scheduleAlarmDateTime.day;
    int mo = scheduleAlarmDateTime.month;
    int ss = DateTime.now().second;
    String Nid = "${mo}${dd}${hh}${mm}${ss}";
    print(Nid);
    print(email);
    int notifId = int.parse("${Nid}");
    int repeteid;
    if (_isRepeating == true) {
      repeteid = 1;
    } else {
      repeteid = 0;
    }
    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: scheduleAlarmDateTime.hour,
      isPending: repeteid,
      isActive: 1,
      isOn: 1,
      title: titlecntr.text,
      nid: notifId,
      description: discntr.text,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    NotificationController.createNewNotification(alarmInfo);
    MyApp.navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (route) => (route.settings.name != '/'));
    setState(() {
      loadAlarms();
      _alarmTime = null;
    });
  }

  void updateison(AlarmInfo alarmInfo) {
    if (alarmInfo.isOn == 1) {
      NotificationController.cancelNotifications(alarmInfo.nid);
    } else {
      NotificationController.createNewNotification(alarmInfo);
    }
    setState(() {
      _alarmHelper.updateisOn(alarmInfo.nid, alarmInfo.isOn);
    });
    loadAlarms();
  }

  void deleteAlarm(int? id, int? Nid, int? isactive) async {
    _alarmHelper.isdelete(id, isactive);
    NotificationController.cancelNotifications(Nid);
    MyApp.navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (route) => (route.settings.name != '/'));
    setState(() {
      loadAlarms();
    });
  }
}
