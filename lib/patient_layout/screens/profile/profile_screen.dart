import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/auth/auth_screen.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/patient_layout/screens/add_doctor_meeting_screen/add_doctor_meeting_screen.dart';
import 'package:medicine_tracker/patient_layout/screens/farmacies_screen/farmacies_Screen.dart';
import 'package:medicine_tracker/patient_layout/screens/profile/widgets/profile_Action_Widget.dart';
import 'package:medicine_tracker/patient_layout/screens/profile/widgets/user_widget.dart';
import 'package:medicine_tracker/patient_layout/screens/reminder_updates_screen/reminder_up%5Bdates_scren.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/adabtive_dialogue.dart';
import '../../../global_widgets/custom_picker_widget.dart';
import '../meetings_screen/meetings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UserWidget(),
            ),
            ProfileActionWidget(
                onTap: () {
                  navigateTo(context, ReminderUpdatesScreen());
                },
                text: 'Reminder Updates'),
            const SizedBox(
              height: 20,
            ),
            ProfileActionWidget(
                onTap: () {
                  navigateTo(context, FarmaciesScreen());
                },
                text: 'Partnerd pharmacies'),
            const SizedBox(
              height: 20,
            ),
            ProfileActionWidget(
                onTap: () {
                  navigateTo(context, AddDoctorMeetingScreen());
                },
                text: 'Add doctor meeting'),
            const SizedBox(
              height: 20,
            ),
            ProfileActionWidget(
                onTap: () {
                  navigateTo(context, MeetingsScreen());
                },
                text: 'Doctors meetings'),
            const SizedBox(
              height: 20,
            ),
            uId != null
                ? ProfileActionWidget(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AdabtiveDialogue(
                                context: context,
                                title: 'Log out ',
                                subtitle: 'All reminders will be canceled',
                                yesFunction: () {
                                  MedCubit.get(context).signOut();
                                  NotificationApi.cancelAll();
                                  Navigator.pop(context);
                                },
                                yesText: 'Log out');
                          });
                    },
                    text: 'Log out')
                : SizedBox(),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is SignOutDone) {
        navigateAndFinish(context, AuthScreen());
      }
    });
  }

  void pillsPicker(context) {
    showCupertinoModalPopup(
        context: context, builder: (_) => CustomPickerWidget());
  }
}
