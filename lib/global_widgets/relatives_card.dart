import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/global_widgets/adabtive_simple_dialogue.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import '../componenets/componenets.dart';
import '../const/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'contact_bottom_sheet.dart';

class RelativesCard extends StatelessWidget {
  String relativeName;
  String relativeLname;
  String relativeuId;
  String relativePhone;
  String relativeEmail;

  RelativesCard({
    Key? key,
    required this.relativeName,
    required this.relativeLname,
    required this.relativeuId,
    required this.relativePhone,
    required this.relativeEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Container(
        child: Row(
          children: [
            CircleAvatar(
              foregroundColor: Colors.black,
              backgroundColor: AppColors.primColor.withOpacity(0.2),
              child: Text(
                '${firstLetter(relativeName)}',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text('${relativeName} ${relativeLname}'),
            Spacer(),
            requestSent(context) == false
                ? PrimaryButton(
                    text: requestSent(context) == false
                        ? 'Send request'
                        : 'Request sent',
                    width: 150,
                    color: AppColors.primColor,
                    height: 40,
                    onPressed: requestSent(context) == true
                        ? null
                        : () {
                            MedCubit.get(context).requestRelative(
                                relativeId: relativeuId,
                                relativeLname: relativeLname,
                                relativeMail: relativeEmail,
                                relativeName: relativeName,
                                relativePhone: relativePhone);
                          })
                : SizedBox(),
            areRelatives(context) == true
                ? PrimaryButton(
                    text: 'Contact',
                    width: 100,
                    height: 40,
                    color: AppColors.primColor,
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          context: context,
                          builder: (context) {
                            return ContactBottomSheet(
                              message:
                                  'Hello ${relativeName} i need help it\'s emergency',
                              phoneNo: relativePhone,
                              name: '${relativeName} ${relativeLname}',
                            );
                          });
                    })
                : SizedBox(),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is SendRequestDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Text('Request sent succusfully'));
            });
      }
    });
  }

  bool requestSent(context) {
    if (MedCubit.get(context)
        .relatives
        .any((element) => element.uid == relativeuId)) {
      return true;
    }
    return false;
  }

  bool areRelatives(context) {
    if (MedCubit.get(context).relatives.any(
        (element) => element.hasAccept == true && element.uid == relativeuId)) {
      return true;
    }
    return false;
  }
}
