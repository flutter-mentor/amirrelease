import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import 'package:medicine_tracker/patient_layout/screens/farmacies_screen/farmacy_widget%20/farmacy_widget.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class FarmaciesScreen extends StatelessWidget {
  const FarmaciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Partners'),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  var farmacy = MedCubit.get(context).allFarmacies[index];
                  return FarmacyWidget(farmacy: farmacy);
                },
                itemCount: MedCubit.get(context).allFarmacies.length,
              ));
        },
        listener: (context, state) {});
  }
}
