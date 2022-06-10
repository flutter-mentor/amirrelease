import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicine_tracker/const/const.dart';

class DbHelper {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static var myDoc = firestore.collection('users').doc(uId);

  static var myReminders =
      firestore.collection('users').doc(uId).collection('reminders');
  static var myRelatives =
      firestore.collection('users').doc(uId).collection('relatives');
}
