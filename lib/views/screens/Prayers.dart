import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/screens/SplashScreen.dart';

class Prayer extends StatefulWidget {
  const Prayer({Key? key}) : super(key: key);

  @override
  State<Prayer> createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  tiemsdfad(String date) {
    final splitted = date.split(":");

    var strDate = '2022-05-20 ${splitted[0]}:${splitted[1]}:00.000';
    try {
      final dateFormat = DateFormat('h:mm a');

      return dateFormat.format(DateTime.parse(strDate));
    } on Exception catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
  
        appBar: AppBar(
      shadowColor: Colors.transparent.withOpacity(0),
          backgroundColor: Colors.green,
          title: Text(
            "Prayer Time",
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold)),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       setState(() {
          //         provider.translated
          //             ? provider.translated = false
          //             : provider.translated = true;
          //       });
          //     },
          //     icon: Icon(Icons.language),
          //     color: Colors.white,
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green.shade100,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            SpHelper.spHelper.getAdress() ??
                                "Please enter your address",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Change address"),
                                        content: TextField(
                                          controller: provider.address,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                provider.changeAdrees();
                                              },
                                              child: const Text("Save")),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: 340.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange.shade300,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${DateFormat.EEEE().format(now)},${DateFormat.d().format(now)} ${DateFormat.MMMM().format(now)}",
                          style: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20),
                  width: 340.w,
                  height: 370.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 3,
                            color: Colors.grey.shade100),
                      ],
                      borderRadius: BorderRadius.circular(30)),
                  child: provider.prayers == null
                      ? Center(child: CircularProgressIndicator())
                      : Column(children: [
                          rowSalah(
                              provider.getFajr(),
                              tiemsdfad(
                                  provider.prayers!.data!.timings!.fajr!)),
                          SizedBox(
                            height: 20.h,
                          ),
                          rowSalah(
                              provider.getDuhur(),
                              tiemsdfad(
                                  provider.prayers!.data!.timings!.dhuhr!)),
                          SizedBox(
                            height: 20.h,
                          ),
                          rowSalah(provider.getAser(),
                              tiemsdfad(provider.prayers!.data!.timings!.asr!)),
                          SizedBox(
                            height: 20.h,
                          ),
                          rowSalah(
                              provider.getMaghreb(),
                              tiemsdfad(
                                  provider.prayers!.data!.timings!.maghrib!)),
                          SizedBox(
                            height: 20.h,
                          ),
                          rowSalah(
                              provider.getIsha(),
                              tiemsdfad(
                                  provider.prayers!.data!.timings!.isha!)),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget rowSalah(String one, String two) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        one,
        style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold)),
      ),
      Text(
        two,
        style: GoogleFonts.cairo(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}
