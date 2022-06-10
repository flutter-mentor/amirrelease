import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/secondary_button.dart';
import 'package:medicine_tracker/models/relatives_model.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../componenets/componenets.dart';
import '../../global_widgets/circular_button.dart';
import '../../global_widgets/primary_button.dart';
import '../../helpers/pdf_data_helper.dart';
import '../../helpers/pdf_helper.dart';
import '../../helpers/report_helper.dart';
import '../../models/user_model.dart';
import '../screens/activity_screen/activity_screen.dart';

class MyPatientCard extends StatelessWidget {
  RequestModel requestModel;
  MyPatientCard({
    Key? key,
    required this.requestModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          '${requestModel.name.characters.first.toUpperCase()}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        backgroundColor: AppColors.primColor.withOpacity(0.3),
                        foregroundColor: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${requestModel.name} ${requestModel.lastname}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            text: 'activity',
                            width: double.infinity,
                            height: 45,
                            color: AppColors.primColor,
                            onPressed: () {
                              navigateTo(
                                  context,
                                  MyPatientActivityScreen(
                                      patientID: requestModel.uid));
                              RelCubit.get(context)
                                  .getPatientData(patientId: requestModel.uid);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context)
                              .getPatientLocation(patientId: requestModel.uid);
                        },
                        icon: Icons.pin_drop_outlined,
                        color: AppColors.primColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context).callPatient(requestModel.phone);
                        },
                        icon: Icons.call,
                        color: AppColors.primColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SecondaryButton(
                        onTap: () {
                          RelCubit.get(context).waPatient(
                              wa: requestModel.phone,
                              quickMessage:
                                  'Hello ${requestModel.name} how are you today...?',
                              context: context);
                        },
                        icon: FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // PrimaryButton(
                  //     text: 'Report',
                  //     width: double.infinity,
                  //     height: 40,
                  //     color: AppColors.primColor,
                  //     onPressed: () async {
                  //       RelCubit.get(context)
                  //           .getPaitientReport(requestModel.uid);
                  //       RelCubit.get(context)
                  //           .getPatientData(patientId: requestModel.uid);
                  //
                  //       for (int i = 0;
                  //           i < RelCubit.get(context).myPatientReports.length;
                  //           i++) {
                  //         var report =
                  //             RelCubit.get(context).myPatientReports[i];
                  //         for (int j = 0; j < report.reminders.length; j++) {
                  //           var medName = report.reminders[j]['medName'];
                  //           List intakes = report.reminders[j]['intakes'];
                  //           var toTake = intakes.length;
                  //           var took = intakes
                  //               .where((element) {
                  //                 return element['took'] == true;
                  //               })
                  //               .toList()
                  //               .length;
                  //           var skip = intakes
                  //               .where((element) {
                  //                 return element['took'] == false;
                  //               })
                  //               .toList()
                  //               .length;
                  //           RelCubit.get(context).reportItemList.add(ReportItem(
                  //                 medicine: medName,
                  //                 day: report.id,
                  //                 toTake: toTake,
                  //                 skip: skip,
                  //                 took: took,
                  //               ));
                  //         }
                  //       }
                  //       final date = DateTime.now();
                  //       final dueDate = date.add(Duration(days: 7));
                  //       final report = Report(
                  //           user: UserModel(
                  //               profilePic: '',
                  //               name:
                  //                   '${RelCubit.get(context).patientModel!.name}',
                  //               phone:
                  //                   '${RelCubit.get(context).patientModel!.phone}',
                  //               eMail:
                  //                   '${RelCubit.get(context).patientModel!.eMail}',
                  //               uId: 'asdas',
                  //               lastname: 'asdas',
                  //               isPatient: RelCubit.get(context)
                  //                   .patientModel!
                  //                   .isPatient),
                  //           info: ReportInfo(
                  //             date: date,
                  //             dueDate: dueDate,
                  //             description:
                  //                 'Showing detailed report of weekly patient progress...',
                  //             number: '${DateTime.now().year}-9999',
                  //           ),
                  //           items: RelCubit.get(context).reportItemList);
                  //
                  //       final pdfFile = await PdfDataHelper.generate(report);
                  //
                  //       PdfHelper.openFile(pdfFile);
                  //     })
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
