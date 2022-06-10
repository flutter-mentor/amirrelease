import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/models/reminder_model.dart';
import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../reminder_detail_screen/reminder_detail_screen.dart';

class ReminderCardWidget extends StatelessWidget {
  ReminderModel reminderModel;
  List intakes = [];
  ReminderCardWidget({
    Key? key,
    required this.reminderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              navigateTo(
                  context,
                  ReminderDetailsScreen(
                    reminderModel: reminderModel,
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor('${reminderModel.color}').withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Icon(FontAwesomeIcons.pills,
                            color: HexColor('${reminderModel.color}')),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reminderModel.medName,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timeline_outlined),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${reminderModel.intakes.length} intakes daily',
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
                                    '${reminderModel.intakes.where((element) {
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.next_plan_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      reminderModel.intakes
                              .where((element) {
                                return element['took'] == false;
                              })
                              .toList()
                              .isNotEmpty
                          ? Row(
                              children: [
                                Text(
                                  ' Next intake ${reminderModel.intakes.where((element) {
                                    return element['took'] == false;
                                  }).toList()[0]['dose']} pills ',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Text(
                                  'at ${DateFormat.jm().format(reminderModel.intakes[0]['time'].toDate())}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )
                          : Text(
                              'Intakes completed',
                              style: Theme.of(context).textTheme.caption,
                            )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
