class UpdateReminderModel {
  late String medName;
  late List intakes;
  late String medColor;
  late int medId;
  late List notfictIds;
  UpdateReminderModel({
    required this.intakes,
    required this.medName,
    required this.medColor,
    required this.medId,
    required this.notfictIds,
  });
  UpdateReminderModel.fromJson(Map<String, dynamic> json) {
    medName = json['medName'];
    intakes = json['intakes'];
    medColor = json['medColor'];
    medId = json['medId'];
    notfictIds = json['notfictIds'];
  }
  Map<String, dynamic> toMap() {
    return {
      'medName': medName,
      'medColor': medColor,
      'intakes': intakes,
      'medId': medId,
      'notfictIds': notfictIds,
    };
  }
}
