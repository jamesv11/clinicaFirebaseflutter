import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpHttpPatient {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createPatient(Map<String, dynamic> patient) async {
    await _db.collection('patients').doc().set(patient).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> updatePatient(
      String id, Map<String, dynamic> patient) async {
    await _db.collection('patients').doc(id).update(patient).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> deletePatient(String id) async {
    await _db.collection('patients').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
}
