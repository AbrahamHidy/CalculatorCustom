import 'package:calculator_custom/helpers/functionProvider.dart';
import 'package:calculator_custom/models/calcLogger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Databaser {
  PreferenceSaver preferenceSaver = new PreferenceSaver();

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

  uploadUserInfo(String email) {}

  uploadCalculation(CalcLogger logger) {
    PreferenceSaver.getUsersEmail().then((email) {
      if (logger.getId() != null) {
        Firestore.instance
            .collection("users")
            .document(email)
            .collection("calcSessions")
            .document(logger.getId())
            .setData(logger.toMap());
      } else {
        Firestore.instance
            .collection("users")
            .document(email)
            .collection("calcSessions")
            .document()
            .setData(logger.toMap());
      }
    });
  }

  Stream<QuerySnapshot> getSavedCalcSessions(String email) {
    return Firestore.instance
        .collection("users")
        .document(email)
        .collection("calcSessions")
        .snapshots();
    //.getDocuments()
    //.asStream();
  }
}
