import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:medicine_tracker/relative_layout/my_patient_reminder_card.dart';
import '../../../helpers/pdf_data_helper.dart';
import '../../../helpers/pdf_helper.dart';
import '../../../helpers/report_helper.dart';
import '../../../models/user_model.dart';
import '../../widgets/my_patient_details_card.dart';

class MyPatientActivityScreen extends StatelessWidget {
  String patientID;
  MyPatientActivityScreen({
    Key? key,
    required this.patientID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      RelCubit.get(context).getPatientActivity(patientID);
      return BlocConsumer<RelCubit, RelativeStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () async {
                      RelCubit.get(context).getPaitientReport(patientID);
                      for (int i = 0;
                          i < RelCubit.get(context).myPatientReports.length;
                          i++) {
                        var report = RelCubit.get(context).myPatientReports[i];
                        for (int j = 0; j < report.reminders.length; j++) {
                          var medName = report.reminders[j]['medName'];
                          List intakes = report.reminders[j]['intakes'];
                          var toTake = intakes.length;
                          var took = intakes
                              .where((element) {
                                return element['took'] == true;
                              })
                              .toList()
                              .length;
                          var skip = intakes
                              .where((element) {
                                return element['took'] == false;
                              })
                              .toList()
                              .length;
                          RelCubit.get(context).reportItemList.add(ReportItem(
                                medicine: medName,
                                day: report.id,
                                toTake: toTake,
                                skip: skip,
                                took: took,
                              ));
                        }
                      }
                      final date = DateTime.now();
                      final dueDate = date.add(Duration(days: 7));
                      final report = Report(
                          user: UserModel(
                              profilePic: '',
                              name:
                                  '${RelCubit.get(context).patientModel!.name}',
                              phone:
                                  '${RelCubit.get(context).patientModel!.phone}',
                              eMail:
                                  '${RelCubit.get(context).patientModel!.eMail}',
                              uId: 'asdas',
                              lastname: 'asdas',
                              isPatient: RelCubit.get(context)
                                  .patientModel!
                                  .isPatient),
                          info: ReportInfo(
                            date: date,
                            dueDate: dueDate,
                            description:
                                'Showing detailed report of weekly patient progress...',
                            number: '${DateTime.now().year}-9999',
                          ),
                          items: RelCubit.get(context).reportItemList);
                      final pdfFile = await PdfDataHelper.generate(report);
                      PdfHelper.openFile(pdfFile);
                    },
                    icon: Icon(Icons.picture_as_pdf_outlined),
                  ),
                ],
                title: Column(
                  children: [
                    RelCubit.get(context).patientModel != null
                        ? Text(
                            '${RelCubit.get(context).patientModel!.name} ${RelCubit.get(context).patientModel!.lastname}')
                        : SizedBox(),
                    Text(
                      'Today\'s activity',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    RelCubit.get(context).patientModel != null
                        ? MyPatientDetailsWidget()
                        : SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (context, index) {
                          var reminder =
                              RelCubit.get(context).myPatintsReminder[index];
                          return MyPatientReminderCard(reminderModel: reminder);
                        },
                        itemCount:
                            RelCubit.get(context).myPatintsReminder.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
