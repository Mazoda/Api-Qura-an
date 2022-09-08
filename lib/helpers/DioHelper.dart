import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:quranapi/data/modules/Audio.dart';
import 'package:quranapi/data/modules/Chapter.dart';
import 'package:quranapi/data/modules/Prayers.dart';
import 'package:quranapi/data/modules/RandomAyah.dart';
import 'package:quranapi/data/modules/Recriactions.dart';
import 'package:quranapi/data/modules/Translation.dart';
import 'package:quranapi/data/modules/Verses.dart';
import 'package:quranapi/data/modules/tafsir.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();
  Dio dio = Dio();

  getAllChapters(String lang) async {
    Response response =
        await dio.get("https://api.quran.com/api/v4/chapters?language=$lang");

    Chapters allChapters = Chapters.fromJson(response.data);
    return allChapters;
  }

  getChapterVerse(int chapterId) async {
    Response response = await dio.get(
        "https://api.quran.com/api/v4/quran/verses/uthmani?chapter_number=${chapterId}");
    ChapterVerse chapterVerse = ChapterVerse.fromJson(response.data);
    return chapterVerse;
  }

  getTafsir(Verses verses) async {
    Response response = await dio.get(
        "https://api.quran.com/api/v4/quran/tafsirs/164?chapter_number=1&verse_key=${verses.verseKey}");
    Tafsirs tafsirs = Tafsirs.fromJson(response.data);
    return tafsirs;
  }

  Future<Translations> getChapterTranslation(int chapter) async {
    Response response = await dio.get(
        "https://api.quran.com/api/v4/quran/translations/167?chapter_number=$chapter");

    Translations translations = Translations.fromJson(response.data);
    return translations;
  }

  getRandomVerseKey() async {
    Response response =
        await dio.get("https://api.quran.com/api/v4/verses/random");
    Randomized randomized = Randomized.fromJson(response.data);
    return randomized.verse!.verseKey;
  }

  getSingelVerse(String? verseKey) async {
    Response response = await dio.get(
        "https://api.quran.com/api/v4/quran/verses/uthmani?verse_key=$verseKey");
    ChapterVerse chapterverse = ChapterVerse.fromJson(response.data);
    Verses verse = chapterverse.verses!.first;
    return verse.textUthmani;
  }

  getAllAudioInfo() async {
    Response response = await dio
        .get("https://api.quran.com/api/v4/resources/recitations?language=ar");
    Recitations recitations = Recitations.fromJson(response.data);
    List<Recitation> recitation = recitations.recitations!;
    return recitation;
  }

  getAudioForSurah(Chapter chapter) async {
    Response response = await dio.get(
        "https://api.quran.com/api/v4/chapter_recitations/1/${chapter.id}");
    AudioResponse audioResponse = AudioResponse.fromJson(response.data);
    return audioResponse.audioFile!.audioUrl;
  }

  getSpecificAudioForSurah(int chapter, int id) async {
    Response response = await dio
        .get("https://api.quran.com/api/v4/chapter_recitations/$id/$chapter");
    AudioResponse audioResponse = AudioResponse.fromJson(response.data);
    return audioResponse.audioFile!.audioUrl;
  }

  // Future<File?> downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  // }

  getAdanTime(String? address) async {
    Response response =
        await dio.get("https://aladhan.p.rapidapi.com/timingsByAddress",
            queryParameters: {
              "address": address ?? "Palestine Gaza"
              //   "country": country,
              //  "city": city
            },
            options: Options(headers: {
              'X-RapidAPI-Key':
                  '466920aef5msh679fe20214f2605p186ac7jsn70732f5425e5',
              'X-RapidAPI-Host': 'aladhan.p.rapidapi.com'
            }));
    Prayers prayers = Prayers.fromJson(response.data);
    log(prayers.data!.timings!.toJson()["Fajr"]);
    return prayers;
  }

  getSingleTafsir(String path) async {
    Response response = await dio
        .get("https://api.quran.com/api/v4/quran/tafsirs/90?verse_key=$path");
    Tafsirs tafsir = Tafsirs.fromJson(response.data);
    // log(tafsir.toJson().toString());
    return tafsir;
  }
}
