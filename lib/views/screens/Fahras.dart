import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/helpers/service.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/widgets/SingleFahrasWidget.dart';
import 'package:workmanager/workmanager.dart';

class Fahras extends StatefulWidget {
  @override
  State<Fahras> createState() => _HomePageState();
}

class _HomePageState extends State<Fahras> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (contex, provider, x) {
      return Scaffold(
        appBar: AppBar(  shadowColor: Colors.transparent.withOpacity(0),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            provider.translated ? "الفهرس" : "Fahras",
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
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
        body: provider.chapters.length < 113
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provider.chapters.length,
                itemBuilder: (context, index) {
                  return FahrasWidget(provider.chapters[index]);
                },
              ),
      );
    });
  }
}
