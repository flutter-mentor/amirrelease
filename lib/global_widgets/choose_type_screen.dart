import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import 'package:medicine_tracker/network/local/cash_helper.dart';

import '../const/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ChooseTypeScreen extends StatelessWidget {
  const ChooseTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Get Started'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Great just one step to get started',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var patient = false;
                          MedCubit.get(context).notPatient(patient);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: MedCubit.get(context).patient == false
                                      ? AppColors.primColor
                                      : Colors.grey)),
                          child: Text(
                            'Relative',
                            style: TextStyle(
                                color: MedCubit.get(context).patient == false
                                    ? AppColors.primColor
                                    : Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          var patient = true;
                          MedCubit.get(context).notPatient(patient);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: MedCubit.get(context).patient == true
                                      ? AppColors.primColor
                                      : Colors.grey)),
                          child: Text(
                            'Patient',
                            style: TextStyle(
                                color: MedCubit.get(context).patient == true
                                    ? AppColors.primColor
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  PrimaryButton(
                      text: 'Get Started',
                      color: AppColors.primColor,
                      width: double.infinity,
                      height: 45,
                      onPressed: () {
                        MedCubit.get(context).setAccountType(context: context);
                        CacheHelper.putBoolean(
                            key: 'type',
                            value: MedCubit.get(context).userModel!.isPatient);
                      }),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
