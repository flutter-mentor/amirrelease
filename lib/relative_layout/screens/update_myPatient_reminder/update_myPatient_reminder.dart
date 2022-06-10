import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/global_widgets/adabtive_simple_dialogue.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import '../../../../global_widgets/primary_button.dart';
import '../../../global_widgets/my_patient_intakes_widget.dart';

class UpdatePatientReminder extends StatefulWidget {
  const UpdatePatientReminder({Key? key}) : super(key: key);

  @override
  State<UpdatePatientReminder> createState() => _UpdatePatientReminderState();
}

class _UpdatePatientReminderState extends State<UpdatePatientReminder> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Update reminder'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor('${RelCubit.get(context).updateMedColor}')
                          .withOpacity(0.5),
                    ),
                    child: Row(
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
                                '${RelCubit.get(context).updateMedColor}'),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              RelCubit.get(context).updatedMedName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(10),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return MyPatientIntakes(
                          index: index,
                          intake: RelCubit.get(context).intakes[index],
                        );
                      },
                      itemCount: RelCubit.get(context).intakes.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is SendUpdateNotfictLoading)
                    LottieBuilder.asset(
                      'assets/loading.json',
                      width: 50,
                    ),
                  if (state is! SendUpdateNotfictLoading)
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              text: 'Send update notification',
                              width: double.infinity,
                              height: 45,
                              color: AppColors.primColor,
                              onPressed: () {
                                RelCubit.get(context).updateMyPatientReminder();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AdabtiveSimpleDialogue(
                                          title: Text(
                                              'Reminder update nottification sent '));
                                    });
                              }),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
