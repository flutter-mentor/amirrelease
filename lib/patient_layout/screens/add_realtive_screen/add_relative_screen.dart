import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/patient_layout/screens/no_internet_patient/no_internet_patient.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/custom_search_filled.dart';
import 'finder_builder.dart';

class AddRelativeScreen extends StatelessWidget {
  const AddRelativeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (MedCubit.get(context).areWeconnectedToIneternt == true) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Add relative'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomSearchBar(
                              placeHolder: 'Search relative phone number',
                              onChange: (v) {
                                MedCubit.get(context).searchForRelative(v);
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          RelativeFinderBuilder(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return NoInternetPatient();
          }
        },
        listener: (context, state) {});
  }
}
