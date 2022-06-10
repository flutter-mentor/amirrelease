import 'package:medicine_tracker/models/user_model.dart';

class Report {
  final ReportInfo info;
//  final Supplier supplier;
  final UserModel user;
  final List<ReportItem> items;

  const Report({
    required this.info,
    //  required this.supplier,
    required this.user,
    required this.items,
  });
}

class ReportInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const ReportInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class ReportItem {
  final String medicine;
  final String day;
  final int toTake;
  final int skip;
  final int took;

  const ReportItem({
    required this.medicine,
    required this.day,
    required this.toTake,
    required this.skip,
    required this.took,
  });
}
