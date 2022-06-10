import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';

import '../const/const.dart';

class CircularButton extends StatelessWidget {
  GestureTapCallback onTap;
  IconData icon;
  CircularButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.primColor),
              ),
              child: Icon(
                icon,
                color: AppColors.primColor,
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
