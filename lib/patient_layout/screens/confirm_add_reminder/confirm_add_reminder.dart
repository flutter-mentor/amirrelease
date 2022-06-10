import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/primary_button.dart';
import '../../patient_layout.dart';

class ConfirmAddMed extends StatelessWidget {
  const ConfirmAddMed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    LottieBuilder.asset('assets/done.json'),
                    Text(
                      'Reminder made successfully',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryButton(
                        text: 'Home screen',
                        width: double.infinity,
                        color: AppColors.primColor,
                        height: 45,
                        onPressed: () {
                          navigateAndFinish(context, PatientLayout());
                        })
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
