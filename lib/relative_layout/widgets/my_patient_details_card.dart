import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../componenets/componenets.dart';
import '../../../const/const.dart';
import '../../global_widgets/primary_button.dart';
import '../../global_widgets/secondary_button.dart';

class MyPatientDetailsWidget extends StatelessWidget {
  const MyPatientDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return Expanded(
              child: Card(
            shadowColor: Colors.grey.withOpacity(0.3),
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: AppColors.primColor.withOpacity(0.2),
                          child: Text(
                            '${firstLetter(RelCubit.get(context).patientModel!.name)}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          RelCubit.get(context).patientModel!.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          RelCubit.get(context).patientModel!.lastname,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              iconColor: Colors.white,
                              icon: Icons.pin_drop_outlined,
                              text: 'location',
                              width: double.infinity,
                              height: 45,
                              color: AppColors.primColor,
                              onPressed: () {
                                RelCubit.get(context).getPatientLocation(
                                    patientId: RelCubit.get(context)
                                        .patientModel!
                                        .uId);
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SecondaryButton(
                            icon: Icons.call,
                            color: AppColors.primColor,
                            onTap: () {
                              RelCubit.get(context).callPatient(
                                  RelCubit.get(context).patientModel!.phone);
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        SecondaryButton(
                            icon: FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                            onTap: () {
                              RelCubit.get(context).waPatient(
                                  context: context,
                                  quickMessage:
                                      'Hello ${RelCubit.get(context).patientModel!.name} how are you today..?',
                                  wa: RelCubit.get(context)
                                      .patientModel!
                                      .phone);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        },
        listener: (context, state) {});
  }
}
