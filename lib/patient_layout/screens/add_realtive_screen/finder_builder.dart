import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/relatives_card.dart';

class RelativeFinderBuilder extends StatelessWidget {
  const RelativeFinderBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          if (MedCubit.get(context).foundUsers.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/not.json',
                  width: 100,
                  height: 100,
                  animate: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No users found',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }
          {
            return Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (context, index) {
                var found = MedCubit.get(context).foundUsers[index];
                return RelativesCard(
                  relativeEmail: found.eMail,
                  relativeLname: found.lastname,
                  relativeName: found.name,
                  relativePhone: found.phone,
                  relativeuId: found.uId,
                );
              },
              itemCount: MedCubit.get(context).foundUsers.length,
            ));
          }
        },
        listener: (context, state) {});
  }
}
