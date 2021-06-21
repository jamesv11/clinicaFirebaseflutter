import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpHttpAppointment {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createAppointment(
      Map<String, dynamic> appointment) async {
    await _db.collection('Appointments').doc().set(appointment).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> updateAppointment(
      String id, Map<String, dynamic> appointment) async {
    await _db
        .collection('Appointments')
        .doc(id)
        .update(appointment)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> deleteAppointment(String id) async {
    await _db.collection('Appointments').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
}
