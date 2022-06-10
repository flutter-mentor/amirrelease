import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/models/medicine_model.dart';
import 'package:medicine_tracker/patient_layout/screens/farmacies_screen/farmacies_Screen.dart';

import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../../../global_widgets/primary_button.dart';

class MedicinesDetaisWidget extends StatelessWidget {
  MedicineModel medicine;
  MedicinesDetaisWidget({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        medicine.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        '${medicine.img}',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Starts from',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'EGP ${medicine.initPrice.toStringAsFixed(2)} ',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primColor.withOpacity(0.2),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.pills,
                              size: 20,
                              color: AppColors.primColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              medicine.effective,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AppColors.primColor),
                            ),
                          ],
                        ),
                      ),
                      PrimaryButton(
                          text: 'Find',
                          color: AppColors.primColor,
                          width: 100,
                          height: 35,
                          onPressed: () {
                            navigateTo(context, FarmaciesScreen());
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Describtion',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    medicine.describtion,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
