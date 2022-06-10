import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/auth/auth_screen.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/patient_layout/screens/user_info_screen/user_info_screen.dart';
import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (uId != null) {
            return Row(
              children: [
                MedCubit.get(context).userModel!.profilePic.isEmpty
                    ? CircleAvatar(
                        foregroundColor: Colors.black,
                        backgroundColor: AppColors.primColor.withOpacity(0.2),
                        child: Text(
                          '${firstLetter(MedCubit.get(context).userModel!.name)}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )
                    : CircleAvatar(
                        foregroundColor: Colors.black,
                        backgroundColor: AppColors.primColor.withOpacity(0.2),
                        backgroundImage: NetworkImage(
                            '${MedCubit.get(context).userModel!.profilePic}')),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  MedCubit.get(context).userModel!.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  MedCubit.get(context).userModel!.lastname,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      navigateTo(context, UserInfoScreen());
                    },
                    child: Text('Info')),
              ],
            );
          }
          return GestureDetector(
            onTap: () {
              navigateAndFinish(context, AuthScreen());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('Login or create an account',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
