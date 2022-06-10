import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/global_widgets/relatives_card.dart';
import 'package:medicine_tracker/models/relatives_model.dart';
import '../../../const/const.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/primary_button.dart';
import '../add_realtive_screen/add_relative_screen.dart';

class RelativesBuilder extends StatelessWidget {
  const RelativesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          final List<RequestModel> myAcceptedRelatives =
              MedCubit.get(context).relatives.where((element) {
            return element.hasAccept == true;
          }).toList();
          if (myAcceptedRelatives.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/not.json',
                  width: 200,
                  height: 200,
                  animate: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No relatives added yet ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    color: AppColors.primColor,
                    text: 'Add now',
                    width: double.infinity,
                    height: 45,
                    onPressed: () {
                      navigateTo(context, AddRelativeScreen());
                    }),
              ],
            );
          } else {
            return Container(
              width: double.infinity,
              height: 200,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (context, index) {
                  var relative = myAcceptedRelatives[index];
                  return RelativesCard(
                      relativeName: relative.name,
                      relativeLname: relative.lastname,
                      relativeuId: relative.uid,
                      relativePhone: relative.phone,
                      relativeEmail: relative.eMail);
                },
                itemCount: myAcceptedRelatives.length,
              ),
            );
          }
        },
        listener: (context, state) {});
  }
}
