import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Translation.dart';
import 'package:quranapi/data/modules/Verses.dart';

class NewVerse extends StatefulWidget {
  int verseNum;
  Chapter chapter;
  Verses verse;
  bool isTranslated = false;
  Translation translation;
  NewVerse(this.verse, this.chapter, this.translation, this.verseNum,
      {Key? key})
      : super(key: key);

  @override
  State<NewVerse> createState() => _NewVerseState();
}

class _NewVerseState extends State<NewVerse> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
        
          child: Text(
            widget.verse.textUthmani!,
            textAlign: TextAlign.right,
            style: GoogleFonts.lateef(
                textStyle:
                    TextStyle(color: Colors.grey.shade700, fontSize: 35.sp)),
          ),
        ),
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
      ],
    );
  }
}
