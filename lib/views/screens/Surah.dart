import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';

import 'package:quranapi/providers/DioProvider.dart';
import 'package:quranapi/views/widgets/NewVerseWidget.dart';
import 'package:quranapi/views/widgets/versesWidget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahScreen extends StatefulWidget {
  Chapter chapter;
  SurahScreen(this.chapter, {Key? key}) : super(key: key);
  int verse = 0;
  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      provider.verseNum = 0;
      return Scaffold(
          appBar: AppBar(
           shadowColor: Colors.transparent.withOpacity(0),
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              provider.translated
                  ? widget.chapter.nameArabic!
                  : widget.chapter.nameSimple!,
              style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  provider.getRecitations(widget.chapter);
                },
                icon: const Icon(
                  Icons.volume_up_outlined,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: provider.verses.isEmpty || provider.translation.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ScrollablePositionedList.builder(
                          itemCount: provider.verses.length + 1,
                          itemBuilder: ((context, index) {
                            index--;
                            return index == -1
                                ? Container(
                                    margin: EdgeInsets.all(10),
                                    child: Image.asset(
                                        "assets/images/Basmalaremovebg.png"))
                                : VerseWidget(
                                    provider.verses[index],
                                    widget.chapter,
                                    provider.translation[index],
                                    index + 1);
                          })),
                    )
                  ],
                ));
    });
  }
}
