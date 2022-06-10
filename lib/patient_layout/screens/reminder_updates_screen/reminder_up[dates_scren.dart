import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class ReminderUpdatesScreen extends StatelessWidget {
  const ReminderUpdatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MedCubit.get(context).getMyReminderUpdates();
      return BlocConsumer<MedCubit, MedStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Reminder Updates'),
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  var updated = MedCubit.get(context).reminderUpdates[index];
                  return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You need to update ${updated.medName}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Your relative made an update for you just hit save',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PrimaryButton(
                              text: 'Save',
                              color: AppColors.primColor,
                              width: double.infinity,
                              height: 45,
                              onPressed: () {
                                MedCubit.get(context).saveNewReminder(
                                    updateReminderModel: updated);
                              }),
                        ],
                      ));
                },
                itemCount: MedCubit.get(context).reminderUpdates.length,
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
