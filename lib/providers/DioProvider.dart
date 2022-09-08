import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quranapi/AppRouter/AppRouter.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Prayers.dart';
import 'package:quranapi/data/modules/Recriactions.dart';
import 'package:quranapi/data/modules/Translation.dart';
import 'package:quranapi/data/modules/Verses.dart';
import 'package:quranapi/data/modules/tafsir.dart';
import 'package:quranapi/helpers/FireStoreHelper.dart';
import 'package:quranapi/helpers/SpHelper.dart';
import 'package:quranapi/views/screens/Allrecitations.dart';
import 'package:quranapi/views/screens/DoaaScreen.dart';
import 'package:quranapi/views/screens/Fahras.dart';
import 'package:quranapi/views/screens/Prayers.dart';
import 'package:quranapi/views/widgets/AudioPlayerWithUrl.dart';
import 'package:quranapi/helpers/DioHelper.dart';
import 'package:quranapi/helpers/service.dart';
import 'package:quranapi/views/screens/Surah.dart';

class DioProvider extends ChangeNotifier {
  List<Chapter> chapters = [];
  List<Verses> verses = [];
  List<Tafsir> tafsir = [];
  List<Translation> translation = [];
  String? audioUrl;
  Verses? verse;
  String? randomVers;
  bool translated = true;
  int verseNum = 0;
  String lang = "ar";
  int? last;
  List<dynamic>? smallDoaa;
  String? cruenntAdan;
  Prayers? prayers;
  String country = "Palestine";
  String city = "Gaza";
  List<Recitation>? recitations;
  TextEditingController address = TextEditingController();
  DioProvider() {
    getAllChapters();
    // getDoaaFromFirebase();
  }

  getAllChapters() async {
    Chapters chapter = await DioHelper.dioHelper.getAllChapters(lang);
    chapters.addAll(chapter.chaptersList ?? []);
    notifyListeners();
  }

  getFahrsPage() async {
    AppRouter.psuhToWidget(Fahras());
    await getAllChapters();
  }

  getChapterVerseAndTranslations(Chapter chapter) async {
    SpHelper.spHelper.saveLast(chapter.id!);
    last = SpHelper.spHelper.getlast();
    notifyListeners();
    AppRouter.psuhToWidget(SurahScreen(chapter));
    verses = [];
    translation = [];
    ChapterVerse chapterVerse =
        await DioHelper.dioHelper.getChapterVerse(chapter.id!);
    verses.addAll(chapterVerse.verses ?? []);
    notifyListeners();

    Translations translations =
        await DioHelper.dioHelper.getChapterTranslation(chapter.id!);
    translation.addAll(translations.translations ?? []);
    notifyListeners();
  }

  getRandomVerseUtmani() async {
    verse = null;
    String? versekey = await DioHelper.dioHelper.getRandomVerseKey();
    randomVers = await DioHelper.dioHelper.getSingelVerse(versekey);
    notifyListeners();
    return randomVers;
  }

  getRecitations(Chapter chapter) async {
    AppRouter.psuhToWidget(AllRecitations(chapter));
    recitations = await DioHelper.dioHelper.getAllAudioInfo();
    notifyListeners();
  }

  getAudioFile(Chapter chapter, Recitation recitation) async {
    audioUrl = await DioHelper.dioHelper
        .getSpecificAudioForSurah(chapter.id!, recitation.id!);
    notifyListeners();
    AppRouter.psuhToWidget(AudioPlayerWithUrl(audioUrl!, chapter, recitation));
  }

  repeatedNotification() async {
    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result) {
    await getRandomVerseUtmani();
    notifyListeners();
    NoificationsApi.repeat("\"${randomVers!}\"");
    // }
    //  else {
    //   // NoificationsApi.repeat("اللهم صّلِ وسَلّمْ عَلۓِ نَبِيْنَامُحَمد ﷺ");
    // }
    // log(randomVers!.toString());
  }

  getAdanTime() async {
    AppRouter.psuhToWidget(Prayer());
    log(SpHelper.spHelper.getAdress()!);
    prayers =
        await DioHelper.dioHelper.getAdanTime(SpHelper.spHelper.getAdress());
    notifyListeners();
  }

  getFajr() {
    return translated ? "الفجر" : "Fajr";
  }

  getDuhur() {
    return translated ? "الظهر" : "Asr";
  }

  getAser() {
    return translated ? "العصر" : "Fajr";
  }

  getMaghreb() {
    return translated ? "المغرب" : "Maghrib";
  }

  getIsha() {
    return translated ? "العشاء" : "Isha";
  }

  changeAdrees() async {
    await SpHelper.spHelper.saveAddress(address.text);
    prayers = await DioHelper.dioHelper.getAdanTime(address.text);
    notifyListeners();
    address.clear();
    notifyListeners();
  }

  getSingleTafsir(String key) async {
    Tafsirs tafsirss = await DioHelper.dioHelper.getSingleTafsir(key);
    tafsir.addAll(tafsirss.tafsir ?? []);

    log(tafsir[3].text.toString());
    notifyListeners();
  }

  getDoaaFromFirebase() async {
    AppRouter.psuhToWidget(DoaaScreen());
    smallDoaa = await FireStoreHelper.firestore.getAllDoaa();
    notifyListeners();
  }

  // getCurrentAdan() async {
  //   // getAdanTime();
  //   await DioHelper.dioHelper.getAdanTime("Palestine Gaze");
  //   if (DateTime.now().hour >= prayers!.data!.timings!.toJson()["Fajr"]) {
  //     return prayers!.data!.timings!.toJson()["Fajr"];
  //   } else if (DateTime.now().hour & DateTime.now().minute >=
  //       prayers!.data!.timings!.toJson()["Dhuhr"]) {
  //     return prayers!.data!.timings!.toJson()["Dhuhr"];
  //   } else if (DateTime.now().hour & DateTime.now().minute >=
  //       prayers!.data!.timings!.toJson()["Asr"]) {
  //     return prayers!.data!.timings!.toJson()["Asr"];
  //   } else if (DateTime.now().hour & DateTime.now().minute >=
  //       prayers!.data!.timings!.toJson()["Maghrib"]) {
  //     return prayers!.data!.timings!.toJson()["Maghrib"];
  //   } else if (DateTime.now().hour & DateTime.now().minute >=
  //       prayers!.data!.timings!.toJson()["Isha"]) {
  //     return prayers!.data!.timings!.toJson()["Isha"];
  //   }
  // }
}
