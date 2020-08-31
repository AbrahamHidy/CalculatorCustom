import 'package:calculator_custom/models/calcLogger.dart';
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

  uploadCalculation(CalcLogger logger) {
    if (logger.getId() != null) {
      Firestore.instance
          .collection("calcSessions")
          .document(logger.getId())
          .setData(logger.toMap());
    } else {
      Firestore.instance
          .collection("calcSessions")
          .document()
          .setData(logger.toMap());
    }
  }
}
