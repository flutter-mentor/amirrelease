import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';
import 'package:medicine_tracker/models/color_model.dart';
import '../../../../const/const.dart';
import '../../../../global_widgets/adabtive_simple_dialogue.dart';
import '../../../../global_widgets/custom_text_filled.dart';
import '../../../../global_widgets/primary_button.dart';

class AddReminderDetailsScreen extends StatelessWidget {
  AddReminderDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create a reminder'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Give your treatment a name ',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFilled(
                      label: 'Name',
                      readOnly: false,
                      isPasword: false,
                      height: 45,
                      controller:
                          MedCubit.get(context).reminderMedNameController,
                      validator: (v) {}),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Pick a color for your treatment',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 40,
                          crossAxisCount: 5),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            MedCubit.get(context)
                                .setSelectedMedColor(colorList[index].color);
                            MedCubit.get(context).setColorIndex(index: index);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                MedCubit.get(context).colorIndex != index &&
                                        MedCubit.get(context).colorTaped
                                    ? HexColor('${colorList[index].color}')
                                        .withOpacity(0.2)
                                    : HexColor('${colorList[index].color}'),
                          ),
                        );
                      },
                      itemCount: colorList.length,
                    ),
                  ),
                  PrimaryButton(
                    text: 'Next',
                    width: double.infinity,
                    height: 45,
                    color: AppColors.primColor,
                    onPressed: MedCubit.get(context).selectedMedColor.isEmpty &&
                            MedCubit.get(context)
                                .reminderMedNameController
                                .text
                                .isEmpty
                        ? null
                        : () {
                            if (MedCubit.get(context)
                                .reminderMedNameController
                                .text
                                .isNotEmpty) {
                              MedCubit.get(context).nestStep();
                              MedCubit.get(context).mediceneNAme =
                                  MedCubit.get(context)
                                      .reminderMedNameController
                                      .text;
                              MedCubit.get(context).addIntakes(
                                  time: MedCubit.get(context).intakeTime,
                                  dose: 1);
                            } else if (MedCubit.get(context)
                                .nameController
                                .text
                                .isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AdabtiveSimpleDialogue(
                                        title:
                                            Text('Please add medicine name '));
                                  });
                            }
                          },
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
