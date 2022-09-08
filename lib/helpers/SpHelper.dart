import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static SpHelper spHelper = SpHelper();
  static SharedPreferences? _sp;
  initS() async {
    _sp = await SharedPreferences.getInstance();
  }

  saveLast(int last) {
    _sp!.setInt("last", last);
  }

  int? getlast() {
    return _sp!.getInt("last");
  }

  saveSurah(int id, List ayat) {
    _sp!.setStringList(id.toString(), []);
  }

  saveAddress(String address) {
    _sp!.setString("address", address);
    log(address);
    // sp!.setString("city", city);
  }

  String? getAdress() {
    return _sp!.getString("address");
  }
  // saverdfas(){
  //   _sp!.setStringList(key, value)
  // }
}
