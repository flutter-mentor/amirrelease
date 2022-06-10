class ReportModel {
  late List reminders;
  late String id;

  ReportModel({
    required this.reminders,
    required this.id,
  });
  ReportModel.fromJson(Map<String, dynamic> json) {
    reminders = json['reminders'];
    id = json['id'];
  }
  Map<String, dynamic> toMap() {
    return {
      'reminders': reminders,
      'id': id,
    };
  }
}
