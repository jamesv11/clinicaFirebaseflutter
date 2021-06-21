import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class HelpHttpCareStaff {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createCareStaff(Map<String, dynamic> careStaff) async {
    await _db.collection('careStaffs').doc().set(careStaff).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> updateCareStaff(
      String id, Map<String, dynamic> careStaff) async {
    await _db
        .collection('careStaffs')
        .doc(id)
        .update(careStaff)
        .catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<void> deleteCareStaff(String id) async {
    await _db.collection('careStaffs').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
}
