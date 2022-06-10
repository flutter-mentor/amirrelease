import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/patient_layout/screens/main_screen/widgets/reminder_card_widget.dart';
import '../../../../const/const.dart';
import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../../../global_widgets/primary_button.dart';
import '../../create_reminder_screen/create_reminder_screen.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (MedCubit.get(context).myReminders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/not.json',
                  width: 200,
                  height: 200,
                  animate: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No reminders added yet ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    color: AppColors.primColor,
                    text: 'Add now',
                    width: double.infinity,
                    height: 45,
                    onPressed: () {
                      navigateTo(context, CreateReminderScreen());
                    }),
              ],
            );
          } else {
            return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (context, index) {
                  return ReminderCardWidget(
                      reminderModel: MedCubit.get(context).myReminders[index]);
                },
                itemCount: MedCubit.get(context).myReminders.length);
          }
        },
        listener: (context, state) {});
  }
}
