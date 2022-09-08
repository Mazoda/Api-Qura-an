import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/providers/DioProvider.dart';

class FahrasWidget extends StatefulWidget {
  Chapter chapter;
  FahrasWidget(this.chapter, {Key? key}) : super(key: key);

  @override
  State<FahrasWidget> createState() => _FahrasWidgetState();
}

class _FahrasWidgetState extends State<FahrasWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return InkWell(
        onTap: () {
          provider.getChapterVerseAndTranslations(widget.chapter);
        },
        child: Container(
            decoration: BoxDecoration(
                color: widget.chapter.id == provider.last
                    ? Colors.grey.shade400
                    : Colors.white,
                border: Border.all(color: Colors.brown.shade200, width: 1)),
            height: 55.h,
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.9)),
                  child: Column(
                    children: [
                      Text(
                        provider.translated ? "الصفحة" : "page",
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(color: Colors.white),
                            fontSize: 11.sp),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.chapter.pages![0].toString(),
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(color: Colors.yellow.shade700),
                            fontSize: 12.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  widget.chapter.revelationPlace == "madinah"
                      ? "assets/images/masjed.ong.png"
                      : "assets/images/kaaba.png",
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  children: [
                    Text(
                      provider.translated ? "اياتها" : "Ayah ",
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      widget.chapter.versesCount.toString(),
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                    provider.translated
                        ? widget.chapter.nameArabic!
                        : widget.chapter.nameSimple!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lateef(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 38.sp,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 50.w,
                  height: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.9)),
                  child: Text(
                    widget.chapter.id!.toString(),
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      );
    });
  }
}
