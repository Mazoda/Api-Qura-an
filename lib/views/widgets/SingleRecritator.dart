import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Recriactions.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/providers/DioProvider.dart';

class Singlerecritation extends StatefulWidget {
  Chapter chapter;
  Recitation recitation;
  Singlerecritation(this.recitation, this.chapter, {Key? key})
      : super(key: key);

  @override
  State<Singlerecritation> createState() => _SinglerecritationState();
}

class _SinglerecritationState extends State<Singlerecritation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Container(
        height: 100.h,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_new),
            InkWell(
              onTap: () {
                provider.getAudioFile(widget.chapter, widget.recitation);
              },
              child: Container(
                  height: 50.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green.shade600,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      const Icon(Icons.mic),
                      Text(provider.translated ? "استمع" : "Listen",
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  )),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    provider.translated
                        ? widget.recitation.translatedName!.name!
                        : widget.recitation.reciterName!,
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold))),
                Text(widget.recitation.style ?? "Murattal",
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: Colors.orange.shade300,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
      );
    });
  }
}
