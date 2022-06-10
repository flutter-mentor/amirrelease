import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/patient_layout/screens/relatives_screen/relative_builder.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../add_realtive_screen/add_relative_screen.dart';

class RelativesScreen extends StatelessWidget {
  const RelativesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                'Relatives',
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, AddRelativeScreen());
                    },
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      color: AppColors.primColor,
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your relatives can track your activity and find your last known location',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RelativesBuilder(),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
