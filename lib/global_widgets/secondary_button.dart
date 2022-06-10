import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';

class SecondaryButton extends StatelessWidget {
  GestureTapCallback onTap;
  IconData icon;
  Color color;
  SecondaryButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 45,
              height: 45,
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
            onTap: onTap,
          );
        },
        listener: (context, state) {});
  }
}
