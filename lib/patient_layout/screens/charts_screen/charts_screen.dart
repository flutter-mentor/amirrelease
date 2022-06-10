// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:medicine_tracker/cubit/cubit.dart';
// import 'package:medicine_tracker/cubit/states.dart';
// import 'package:medicine_tracker/models/progress_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class ChartsScreen extends StatefulWidget {
//   const ChartsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChartsScreen> createState() => _ChartsScreenState();
// }
//
// class _ChartsScreenState extends State<ChartsScreen> {
//   TooltipBehavior? _tooltipBehavior;
//
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var days =
//         DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;
//
//     return BlocConsumer<MedCubit, MedStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Progress'),
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: ListView.builder(
//                   padding: EdgeInsets.all(8),
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     var medicine = MedCubit.get(context).myReminders[index];
//                     return Container(
//                       child: Text('${medicine.medName}'),
//                     );
//                   },
//                   itemCount: MedCubit.get(context).myReminders.length,
//                 ),
//               ),
//               Expanded(
//                 flex: 5,
//                 child: SfCartesianChart(
//                   primaryXAxis: CategoryAxis(),
//                   legend: Legend(isVisible: true),
//                   tooltipBehavior: _tooltipBehavior,
//                   series: <LineSeries<ProgressModel, String>>[
//                     LineSeries<ProgressModel, String>(
//                       dataSource: <ProgressModel>[
//                         ProgressModel(
//                             medName: 'Panadol', day: "Sat", takenPills: 500),
//                         ProgressModel(
//                             medName: 'Panadol', day: "Sun", takenPills: 500),
//                         ProgressModel(
//                             medName: 'paramol', day: "Mon", takenPills: 30),
//                         ProgressModel(medName: 'rr', day: "Tue", takenPills: 1),
//                         ProgressModel(
//                             medName: 'asds', day: "Wed", takenPills: 500),
//                         ProgressModel(
//                             medName: 'Panadol', day: "Thu", takenPills: 500),
//                         ProgressModel(
//                             medName: 'tadol', day: "Fri", takenPills: 500),
//                       ],
//                       xValueMapper: (ProgressModel med, _) => med.day,
//                       yValueMapper: (ProgressModel med, _) => med.takenPills,
//                       dataLabelSettings: DataLabelSettings(isVisible: true),
//                       sortFieldValueMapper: (ProgressModel med, _) =>
//                           med.medName,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medicine_tracker/const/const.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../helpers/pdf_data_helper.dart';
import '../../../helpers/pdf_helper.dart';
import '../../../helpers/report_helper.dart';
import '../../../models/user_model.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  @override
  void initState() {
    MedCubit.get(context).addReport();
    MedCubit.get(context).myReports = [];
    MedCubit.get(context).getAllReports();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Progress'),
              actions: [
                IconButton(
                    onPressed: () async {
                      MedCubit.get(context).reportITemList = [];
                      for (int i = 0;
                          i < MedCubit.get(context).myReports.length;
                          i++) {
                        var report = MedCubit.get(context).myReports[i];
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
                          // var r = MedCubit.get(context).myReports[i];
                          // intakes = report.reminders[i]['intakes'];
                          // var took = intakes.where((element) {
                          //   return element['took'] == true;
                          // }).toList();
                          // var skip = intakes.where((element) {
                          //   return element['took'] == false;
                          // }).toList();
                          MedCubit.get(context).reportITemList.add(ReportItem(
                                medicine: medName,
                                // medicine: report.reminders[i]['medName'],
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
                              name: '${MedCubit.get(context).userModel!.name}',
                              phone:
                                  '${MedCubit.get(context).userModel!.phone}',
                              eMail:
                                  '${MedCubit.get(context).userModel!.eMail}',
                              uId: 'asdas',
                              lastname: 'asdas',
                              isPatient: true),
                          info: ReportInfo(
                            date: date,
                            dueDate: dueDate,
                            description:
                                'Showing detailed report of weekly patient progress...',
                            number: '${DateTime.now().year}-9999',
                          ),
                          items: MedCubit.get(context).reportITemList
                          // items: MedCubit.get(context).myReports.map((e) {
                          //   return ReportItem(
                          //       medicine: e.reminders[0]['medName'],
                          //       date: DateTime.now(),
                          //       toTake: 2,
                          //       skip: 1,
                          //       took: 1);
                          // }).toList(),
                          // // items: [
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // //   ReportItem(
                          // //     medicine: 'Water',
                          // //     date: DateTime.now(),
                          // //     toTake: 3,
                          // //     skip: 1,
                          // //     took: 2,
                          // //   ),
                          // // ],
                          );

                      final pdfFile = await PdfDataHelper.generate(report);

                      PdfHelper.openFile(pdfFile);
                    },
                    icon: Icon(
                      Icons.picture_as_pdf_outlined,
                      color: AppColors.primColor,
                    )),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 36,
                          );
                        },
                        itemBuilder: (context, index) {
                          var report = MedCubit.get(context).myReports[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                report.id,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                child: Row(
                                  children:
                                      MedCubit.get(context).myReports.map((e) {
                                    return Row(
                                      children: e.reminders.map((remind) {
                                        return Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: HexColor(
                                                        '${remind['color']}')
                                                    .withOpacity(0.6),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    remind['medName'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons
                                                              .timeline_outlined),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '${remind['intakes'].length} intakes daily',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.schedule),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '${remind['intakes'].where((element) {
                                                                  return element[
                                                                          'took'] ==
                                                                      false;
                                                                }).toList().length} remaining',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    );
                                  }).toList(),
                                ),
                                scrollDirection: Axis.horizontal,
                              )
                            ],
                          );
                        },
                        itemCount: MedCubit.get(context).myReports.length,
                      ),
                    ),
                  ],
                )),
          );
        },
        listener: (context, state) {});
  }
}
