import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Doaa.dart';
import 'package:quranapi/helpers/service.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/screens/HomePage.dart';
import 'package:workmanager/workmanager.dart';

final dioProvider = DioProvider();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late final NoificationsApi service;
  late final DioProvider dioProvider;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          // context, MaterialPageRoute(builder: (_) => Fahras()));
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()));
    });
    dioProvider = DioProvider();
    service = NoificationsApi();
    service.notificationInitialize();
    Workmanager().initialize(callbackDispatcher,
    //  isInDebugMode: true
     );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // navigatFun();
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300.w,
                height: 300.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Quran.png",
                    ),
                  ),
                ),
              ),
              Text(
                "Al Quran- القرأن الكريم",
                style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color:const Color.fromARGB(255, 62, 146, 157),
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      );
    });
  }
}

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future showNotification() async {
  int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '$rndmIndex.0',
    "دعاء",
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    styleInformation:const BigTextStyleInformation(''),
  );
  var iOSPlatformChannelSpecifics =const IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin!.show(
    rndmIndex,
    'فَذَكِّرْ',
    StaticVars().smallDo3a2[rndmIndex],
    platformChannelSpecifics,
  );
}

callbackDispatcher() {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@drawable/quran');

  var initializationSettingsIOS = const IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin!.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      await DioProvider().repeatedNotification();
      return Future.value(true);
    } else {
      showNotification();
      return Future.value(true);
    }
  }
  );
}
