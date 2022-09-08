import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/AppRouter/AppRouter.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/screens/Fahras.dart';
import 'package:quranapi/views/screens/Prayers.dart';
import 'package:quranapi/views/widgets/HomeGrid.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Workmanager().registerPeriodicTask(
      "1",
      "periodic Notification",
      frequency: const Duration(minutes: 15),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(  shadowColor: Colors.transparent.withOpacity(0),
          title: const Text("Al Quran- القرأن الكريم"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  provider.translated
                      ? provider.translated = false
                      : provider.translated = true;
                });
              },
              icon: Icon(Icons.language),
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(children: [
            InkWell(
                onTap: () {
                  provider.getFahrsPage();
                },
                child: HomePageGrid("surahIndex.png",
                    provider.translated ? "السور" : "Surah Index")),
            InkWell(
                onTap: () {
                  provider.getAdanTime();
                },
                child: HomePageGrid("AdanTime.png",
                    provider.translated ? "أوقات الصلاة" : "Prayer Times")),
            InkWell(
                onTap: () {
                  provider.getDoaaFromFirebase();
                },
                child: HomePageGrid(
                    "84660.png", provider.translated ? "أدعية" : "Doaa")),
          ]),
        ),
      );
    });
  }
}
