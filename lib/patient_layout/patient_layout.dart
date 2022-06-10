import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/patient_layout/screens/no_internet_patient/no_internet_patient.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class PatientLayout extends StatelessWidget {
  bool patient = false;
  // const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (MedCubit.get(context).userModel != null) {}
      return BlocConsumer<MedCubit, MedStates>(
          builder: (context, state) {
            if (MedCubit.get(context).areWeconnectedToIneternt == true) {
              return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: MedCubit.get(context).bottomNavBarIndex,
                    onTap: (index) {
                      MedCubit.get(context).changeBottomNavBar(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.bar_chart),
                        label: 'Progress',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.group),
                        label: 'Relatives',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.user),
                        label: 'Me',
                      ),
                    ],
                  ),
                  body: MedCubit.get(context)
                      .appScreens[MedCubit.get(context).bottomNavBarIndex]);
            } else {
              return NoInternetPatient();
            }
          },
          listener: (context, state) {});
    });
  }
}
