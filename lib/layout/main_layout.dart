import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/patient_layout/patient_layout.dart';
import 'package:medicine_tracker/relative_layout/relative_layout.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (uId != null &&
              MedCubit.get(context).userModel != null &&
              MedCubit.get(context).userModel!.isPatient == false) {
            return RelativeLayout();
          } else {
            return PatientLayout();
          }
        },
        listener: (context, state) {});
  }
}
