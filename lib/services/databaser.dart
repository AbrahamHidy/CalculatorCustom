import 'package:cloud_firestore/cloud_firestore.dart';

class Databaser {
  getUserWithUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserWithEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance
        .collection("users")
        .add(userMap)
        .catchError((e) => print(e.toString()));
  }
}
