import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../../../global_widgets/intake_widget.dart';
import '../../../../global_widgets/primary_button.dart';

class SetIntakesScreen extends StatelessWidget {
  const SetIntakesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create reminder'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          HexColor('${MedCubit.get(context).selectedMedColor}')
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
                                '${MedCubit.get(context).selectedMedColor}'),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MedCubit.get(context)
                                  .reminderMedNameController
                                  .text,
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
                        return IntakeWidget(
                          index: index,
                          intake: MedCubit.get(context).intakes[index],
                        );
                      },
                      itemCount: MedCubit.get(context).intakes.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is AddReminderLoading)
                    LottieBuilder.asset(
                      'assets/loading.json',
                      width: 50,
                    ),
                  if (state is! AddReminderLoading)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              MedCubit.get(context).previousStep();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.primColor,
                                  )),
                              child: Text(
                                'Previous',
                                style: TextStyle(color: AppColors.primColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                              text: 'Save',
                              width: double.infinity,
                              height: 45,
                              color: AppColors.primColor,
                              onPressed: () {
                                MedCubit.get(context).saveReminder(
                                  medName: MedCubit.get(context)
                                      .reminderMedNameController
                                      .text,
                                );
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
