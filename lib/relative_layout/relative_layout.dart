import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import '../const/const.dart';

class RelativeLayout extends StatelessWidget {
  const RelativeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RelCubit, RelativeStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.2,
              centerTitle: false,
              title: Text(
                'Medication tracker',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColors.primColor),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: RelCubit.get(context).bootmRelativeLayout,
              onTap: (index) {
                RelCubit.get(context).changeRelativeBottomLayout(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'Patients'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user), label: 'Me')
              ],
            ),
            body: RelCubit.get(context)
                .relativeScreens[RelCubit.get(context).bootmRelativeLayout],
          );
        },
        listener: (context, state) {});
  }
}
