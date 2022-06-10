import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicine_tracker/const/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../global_widgets/primary_button.dart';

class PatientLocationWidget extends StatelessWidget {
  const PatientLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (MedCubit.get(context).patientPostition == null) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primColor.withOpacity(0.3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    color: AppColors.primColor,
                    size: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable location ',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'To allow relatives to find you',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  PrimaryButton(
                    text: 'Enable',
                    width: 100,
                    height: 50,
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                    },
                    color: AppColors.primColor,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
        listener: (context, state) {});
  }
}
