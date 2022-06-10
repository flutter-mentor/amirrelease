import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class DueReminderWidget extends StatefulWidget {
  String reminderId;
  // String pyload;
  DueReminderWidget({
    Key? key,
    required this.reminderId,
    // required this.pyload,
  }) : super(key: key);

  @override
  State<DueReminderWidget> createState() => _DueReminderWidgetState();
}

class _DueReminderWidgetState extends State<DueReminderWidget> {
  @override
  void initState() {
    if (MedCubit.get(context).dueReminderModel != null) {
      MedCubit.get(context).getDueReminder(reminderId: widget.reminderId);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<MedCubit, MedStates>(
          builder: (context, state) {
            var currentIntake;
            if (MedCubit.get(context).dueReminderModel != null) {
              MedCubit.get(context)
                  .getDueReminder(reminderId: widget.reminderId);
            }
            if (MedCubit.get(context).dueReminderModel != null) {
              currentIntake = MedCubit.get(context)
                  .dueReminderModel!
                  .intakes
                  .where((element) {
                return element['took'] == false;
              }).toList();
            }
            return ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            nowReminderText(context: context),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            DateFormat('hh:mm a').format(DateTime.parse(
                                nowReminderTimeText(context: context))),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
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
                              color: HexColor(
                                  '${MedCubit.get(context).dueReminderModel!.color}'),
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
                                '${MedCubit.get(context).dueReminderModel!.medName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.timeline_outlined),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${MedCubit.get(context).dueReminderModel!.intakes.length} intakes daily',
                                        style: Theme.of(context)
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
                                        '${MedCubit.get(context).dueReminderModel!.intakes.where((element) {
                                              return element['took'] == false;
                                            }).toList().length} remaining',
                                        style: Theme.of(context)
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
                        ],
                      ),
                    ],
                  ),
                  width: double.infinity,
                  color: HexColor(
                          '${'${MedCubit.get(context).dueReminderModel!.color}'}')
                      .withOpacity(0.5),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            text: 'Skip',
                            width: double.infinity,
                            height: 45,
                            color: Colors.red,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: PrimaryButton(
                            text: 'Accept',
                            width: double.infinity,
                            height: 45,
                            color: Colors.green,
                            onPressed: () {
                              List newIntakes = [];
                              newIntakes = MedCubit.get(context)
                                  .dueReminderModel!
                                  .intakes;
                              newIntakes[0]['took'] = true;
                              MedCubit.get(context).updateIntake(
                                  id: widget.reminderId,
                                  updatedList: newIntakes);
                              Navigator.pop(context);
                              // MedCubit.get(context).dueReminderModel = null;
                            }),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          listener: (context, state) {});
    });
  }

  String nowReminderText({
    required BuildContext context,
  }) {
    if (MedCubit.get(context).dueReminderModel != null &&
        widget.reminderId != null) {
      MedCubit.get(context).getDueReminder(reminderId: widget.reminderId);
    }
    return MedCubit.get(context)
            .dueReminderModel!
            .intakes
            .where((element) {
              return element['took'] == false;
            })
            .toList()[0]['dose']
            .toString() +
        ' pills now';
  }

  nowReminderTimeText({
    required BuildContext context,
  }) {
    if (MedCubit.get(context).dueReminderModel != null) {
      MedCubit.get(context).getDueReminder(reminderId: widget.reminderId);
    }
    return MedCubit.get(context)
        .dueReminderModel!
        .intakes
        .where((element) {
          return element['took'] == false;
        })
        .toList()[0]['time']
        .toDate()
        .toString();
  }
}
