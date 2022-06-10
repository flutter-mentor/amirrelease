import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/adabtive_simple_dialogue.dart';
import 'package:medicine_tracker/global_widgets/custom_text_filled.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class AddDoctorMeetingScreen extends StatefulWidget {
  const AddDoctorMeetingScreen({Key? key}) : super(key: key);

  @override
  State<AddDoctorMeetingScreen> createState() => _AddDoctorMeetingScreenState();
}

class _AddDoctorMeetingScreenState extends State<AddDoctorMeetingScreen> {
  DateTime? meetingAt;
  String formatedText = '';
  @override
  Widget build(BuildContext context) {
    var dNameContlr = TextEditingController();
    var cauzCntrl = TextEditingController();

    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add doctor meeting'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    _showDatePicker(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: AppColors.primColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          meetingAt == null
                              ? 'choose meeting time'
                              : formatedText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 16,
              ),
              CustomTextFilled(
                  label: 'doctor\'s name',
                  readOnly: false,
                  isPasword: false,
                  height: 45,
                  controller: dNameContlr,
                  validator: (v) {}),
              const SizedBox(
                height: 16,
              ),
              CustomTextFilled(
                  label: 'Reason of visit',
                  readOnly: false,
                  isPasword: false,
                  height: 45,
                  controller: cauzCntrl,
                  validator: (v) {}),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                  text: 'Save meeting',
                  width: double.infinity,
                  height: 45,
                  color: AppColors.primColor,
                  onPressed: () {
                    if (dNameContlr.text.isEmpty ||
                        cauzCntrl.text.isEmpty ||
                        meetingAt == null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AdabtiveSimpleDialogue(
                                title: Text('Please fill data'));
                          });
                    } else if (dNameContlr.text.isNotEmpty &&
                        cauzCntrl.text.isNotEmpty &&
                        meetingAt != null) {
                      MedCubit.get(context).addMeeting(
                          docName: dNameContlr.text,
                          reaseon: cauzCntrl.text,
                          meetingAt: meetingAt!);
                    }
                  }),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is AddMeetingDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(title: Text('Meeting Added'));
            });
      }
    });
  }

  void _showDatePicker(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (val) {
                    setState(() {
                      meetingAt = val;
                      // widget.intake.time = val;
                      String formattedDate =
                          DateFormat('dd-MM-yyyy hh:mm aa').format(meetingAt!);
                      formatedText = formattedDate;
                      print(meetingAt);
                    });
                  }),
            ),

            // Close the modal
            CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
