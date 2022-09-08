import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Translation.dart';
import 'package:quranapi/data/modules/Verses.dart';
import 'package:quranapi/providers/DioProvider.dart';
import 'package:share_plus/share_plus.dart';

class VerseWidget extends StatefulWidget {
  int verseNum;
  Chapter chapter;
  Verses verse;
  bool isTranslated = false;
  Translation translation;
  VerseWidget(this.verse, this.chapter, this.translation, this.verseNum,
      {Key? key})
      : super(key: key);

  @override
  State<VerseWidget> createState() => _VerseWidgetState();
}

class _VerseWidgetState extends State<VerseWidget> {
  void _onShareWithResult(String text) async {
    await Share.share(text);
    // subject: "subject",
    // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size)
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Column(
          children: [
            Container(
              height: 40.h,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(left: 30.w),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/images/ayah.png")),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.verseNum.toString(),
                        style: const TextStyle(color: Colors.black),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.verseNum = widget.verseNum;
                        widget.isTranslated
                            ? widget.isTranslated = false
                            : widget.isTranslated = true;
                      });
                    },
                    icon: const Icon(Icons.language),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _onShareWithResult(
                            "\{ ${widget.verse.textUthmani} \} \n ${widget.chapter.nameArabic} :${widget.verseNum} ");
                      });
                    },
                    icon: const Icon(Icons.share),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.verse.textUthmani!,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.lateef(
                          textStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 35.sp)),
                      // cursorColor: Colors.yellow.shade700,
                      // showCursor: true,
                    ),
                  ),
                  widget.isTranslated
                      ? SizedBox(
                          width: double.infinity,
                          child: Text(widget.translation.text!,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.lateef(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 35.sp))),
                        )
                      : const Text(""),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
