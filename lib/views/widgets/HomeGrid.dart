import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageGrid extends StatelessWidget {
  String name;
  String image;
  HomePageGrid(this.image, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                spreadRadius: 3, blurRadius: 3, color: Colors.grey.shade300)
          ]),
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.only(top: 10.h),
      child: Column(children: [
        Image.asset(
          "assets/images/$image",
          width: 120.w,
          height: 120.h,
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          name,
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600)),
          // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
        ),
      ]),
    );
  }
}
