import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper firestore = FireStoreHelper._();
  // FirebaseFirestore firestoreinstance = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> doaaCollection =
      FirebaseFirestore.instance.collection("doaa");

  Future<List<dynamic>> getAllDoaa() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await doaaCollection.doc("cFpI9VJlC0R6zyeR11tV").get();
    Map<String, dynamic>? doaa = querySnapshot.data();
    List<dynamic> smallDoaa = doaa!["smallDoaa"];
    return smallDoaa;
  }
}
