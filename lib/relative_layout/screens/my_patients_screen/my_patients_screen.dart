import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:medicine_tracker/relative_layout/widgets/my_patient_card.dart';

class MyPatientsScreen extends StatelessWidget {
  const MyPatientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      RelCubit.get(context).getAllPatients();
      return BlocConsumer<RelCubit, RelativeStates>(
          builder: (context, state) {
            return Container(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return MyPatientCard(
                      requestModel: RelCubit.get(context).myPatients[index]);
                },
                itemCount: RelCubit.get(context).myPatients.length,
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
