import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class MeetingsScreen extends StatefulWidget {
  @override
  State<MeetingsScreen> createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  @override
  void initState() {
    MedCubit.get(context).meetinsList = [];
    MedCubit.get(context).getAllMeetings();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Meetings'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MedCubit.get(context).meetinsList.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.all(20),
                              itemBuilder: (context, index) {
                                var meeting =
                                    MedCubit.get(context).meetinsList[index];
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You have a meeting with ${meeting.doctorName}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'for ${meeting.cauuz} reason',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'at ${DateFormat('dd-MM-yyyy hh:mm aa').format(meeting.meetingAt.toDate())}',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      PrimaryButton(
                                          text: 'Remove',
                                          width: double.infinity,
                                          height: 40,
                                          color: Colors.red,
                                          onPressed: () {
                                            MedCubit.get(context)
                                                .deleteMeeting(meeting.id);
                                          })
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount:
                                  MedCubit.get(context).meetinsList.length),
                        )
                      : Text(
                          'No Meetings added',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
