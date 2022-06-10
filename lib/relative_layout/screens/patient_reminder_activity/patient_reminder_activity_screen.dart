import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/models/reminder_model.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/adabtive_dialogue.dart';
import '../../../global_widgets/adabtive_simple_dialogue.dart';
import '../../../global_widgets/primary_button.dart';
import '../update_myPatient_reminder/update_myPatient_reminder.dart';

class PatientReminderDetailsScreen extends StatelessWidget {
  ReminderModel reminderModel;
  List upDateList = [];
  List tempList = [];
  PatientReminderDetailsScreen({
    Key? key,
    required this.reminderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    upDateList = reminderModel.intakes;
    tempList = reminderModel.intakes.where((element) {
      return element['took'] == false;
    }).toList();
    return BlocConsumer<RelCubit, RelativeStates>(builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 20,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(26),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    text: 'Update',
                    width: double.infinity,
                    color: AppColors.primColor,
                    height: 40,
                    onPressed: () {
                      RelCubit.get(context).intakes = [];
                      navigateTo(context, UpdatePatientReminder());
                      RelCubit.get(context).setUpdatedMedData(
                          notfictIdsList: reminderModel.notfictIds,
                          patId: reminderModel.uid,
                          medId: reminderModel.id,
                          medName: reminderModel.medName,
                          medDColor: reminderModel.color,
                          oldIntakes: reminderModel.intakes);
                    }),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Column(
            children: [
              Text(reminderModel.medName),
              Text(
                '${reminderModel.intakes.length} intakes daily',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Icon(
                      FontAwesomeIcons.pills,
                      color: HexColor('${reminderModel.color}'),
                      size: 30,
                    ),
                    width: 75,
                    height: 75,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminderModel.medName,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${reminderModel.intakes.length} intakes daily',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${reminderModel.intakes.where((element) {
                                  return element['took'] == false;
                                }).toList().length} intakes remaining',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              width: double.infinity,
              color: HexColor('${reminderModel.color}').withOpacity(0.5),
            ),
            Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                      title: Row(
                        children: [
                          Text(
                            '${reminderModel.intakes[index]['dose'].toStringAsFixed(2)} pills',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' at ${DateFormat.jm().format(reminderModel.intakes[index]['time'].toDate())}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      value: reminderModel.intakes[index]['took'],
                      onChanged: reminderModel.intakes[index]['took'] == false
                          ? (v) {
                              upDateList[index]['took'] = v;
                              RelCubit.get(context).updateMyPatientIntake(
                                  reminderId: reminderModel.id.toString(),
                                  patientId: reminderModel.uid,
                                  updatedList: upDateList);
                            }
                          : null);
                },
                itemCount: reminderModel.intakes.length,
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is ResetReminderDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Text('Reminder reset done '));
            }).then((value) {
          Navigator.pop(context);
        });
      }
      if (state is DeleteRelativeDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(title: Text('Reminder deleted '));
            }).then((value) {
          Navigator.pop(context);
        });
      }
    });
  }
}
