import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/const/const.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class SoundModeWidget extends StatelessWidget {
  const SoundModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primColor,
            ),
            child: Row(
              children: [
                Text(
                  'Please activeate sound mode in order to hear sound notifications',
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
