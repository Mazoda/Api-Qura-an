import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';

import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/widgets/singleDoaaWidget.dart';
import 'package:quranapi/views/widgets/versesWidget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DoaaScreen extends StatefulWidget {
  DoaaScreen();
  @override
  State<DoaaScreen> createState() => _DoaaScreentate();
}

class _DoaaScreentate extends State<DoaaScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      provider.verseNum = 0;
      return Scaffold(
          appBar: AppBar(backgroundColor: Colors.black,
          shadowColor: Colors.transparent.withOpacity(0),
            centerTitle: true,
            title: Text(
              provider.translated ? "أدعية" : "Doaa ",
              style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          body: provider.smallDoaa == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: provider.smallDoaa!.length,
                          itemBuilder: ((context, index) {
                            // log(provider.smallDoaa![index]);
                            return DoaaWdiget(provider.smallDoaa![index]);
                          })),
                    )
                  ],
                ));
    });
  }
}
