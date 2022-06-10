import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  late String doctorName;
  late Timestamp meetingAt;
  late String cauuz;
  late String id;
  late String uid;
  MeetingModel({
    required this.uid,
    required this.id,
    required this.doctorName,
    required this.meetingAt,
    required this.cauuz,
  });
  MeetingModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    id = json['id'];
    doctorName = json['doctorName'];
    meetingAt = json['meetingAt'];
    cauuz = json['cauuz'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'doctorName': doctorName,
      'meetingAt': meetingAt,
      'cauuz': cauuz,
    };
  }
}
