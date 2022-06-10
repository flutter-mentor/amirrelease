import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  late String medName;
  late String hint;
  late Timestamp createdAt;
  late int id;
  late List intakes;
  late List routine;
  late List notfictIds;
  late String color;
  late String uid;
  ReminderModel({
    required this.medName,
    required this.createdAt,
    required this.id,
    required this.hint,
    required this.intakes,
    required this.routine,
    required this.notfictIds,
    required this.color,
    required this.uid,
  });
  ReminderModel.fromJson(Map<String, dynamic> json) {
    medName = json['medName'];
    createdAt = json['createdAt'];
    hint = json['hint'];
    id = json['id'];
    intakes = json['intakes'];
    routine = json['routine'];
    notfictIds = json['notfictIds'];
    color = json['color'];
    uid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'medName': medName,
      'createdAt': createdAt,
      'id': id,
      'hint': hint,
      'intakes': intakes,
      'routine': routine,
      'notfictIds': notfictIds,
      'color': color,
      'uid': uid,
    };
  }
}
