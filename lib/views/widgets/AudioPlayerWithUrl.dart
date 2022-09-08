import 'dart:developer';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Recriactions.dart';
import 'package:quranapi/providers/DioProvider.dart';

class AudioPlayerWithUrl extends StatefulWidget {
  Recitation recitation;
  String url;
  Chapter chapter;
  AudioPlayerWithUrl(this.url, this.chapter, this.recitation);

  @override
  State<AudioPlayerWithUrl> createState() => _AudioPlayerWithUrlState();
}

class _AudioPlayerWithUrlState extends State<AudioPlayerWithUrl> {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPaused = false;
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    audioPlayer.setSourceUrl(widget.url);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    super.initState();
  }

  Widget slider() {
    return slider();
  }

  void changeToSce(int secs) {
    Duration newDuration = Duration(seconds: secs);
    position = newDuration;
    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DioProvider>(builder: (context, provider, x) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent.withOpacity(0),
            shadowColor: Colors.transparent,
            // leading: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   radius: 30,
            //   child: IconButton(
            //     onPressed: () async {
            //       Navigator.of(context).pop();
            //     },
            //     icon: const Icon(
            //       Icons.arrow_back,
            //       color: Colors.green,
            //     ),
            //   ),
            // ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (isPlaying) {
                await audioPlayer.release();
                await audioPlayer.stop();
                return Future.value(true);
              } else {
                await audioPlayer.release();
                await audioPlayer.stop();
                return Future.value(true);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  image: const DecorationImage(
                      opacity: 0.5,
                      image: AssetImage(
                        "assets/images/kaaba.jpeg",
                      ),
                      fit: BoxFit.cover)),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    provider.translated
                        ? Text(
                            widget.recitation.translatedName!.name!,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold)),
                          )
                        : Text(
                            widget.recitation.reciterName!,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                    provider.translated
                        ? Text("سورة ${widget.chapter.nameArabic} ",
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold)))
                        : Text(widget.chapter.nameSimple!,
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold))),
                    Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.green.shade900,
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (double value) async {
                          setState(() {
                            changeToSce(value.toInt());
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(formatDuration(position)),
                          Text(
                            position.toString().split(".")[0],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: IconButton(
                              onPressed: () async {
                                if (isPlaying == false) {
                                  audioPlayer.play(UrlSource(widget.url));
                                  setState(() {
                                    isPlaying = true;
                                  });
                                } else if (isPlaying == true) {
                                  audioPlayer.pause();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                }
                              },
                              icon: Icon(
                                isPlaying == false
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Text(
                            duration.toString().split(".")[0],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 130.h,
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
