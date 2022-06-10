import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ContactBottomSheet extends StatelessWidget {
  String phoneNo;
  String message;
  String? name;
  ContactBottomSheet({
    Key? key,
    required this.message,
    this.name,
    required this.phoneNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel_outlined),
                    ),
                    Text(
                      name == null
                          ? 'Contact your relative'
                          : 'Contact ${name}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                    icon: Icons.call,
                    iconColor: Colors.white,
                    text: 'call',
                    width: double.infinity,
                    height: 50,
                    color: AppColors.primColor,
                    onPressed: () {
                      launch('tel:${phoneNo}');
                    }),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                    icon: FontAwesomeIcons.whatsapp,
                    iconColor: Colors.white,
                    text: 'Whatsapp',
                    width: double.infinity,
                    height: 50,
                    color: Colors.green,
                    onPressed: () {
                      MedCubit.get(context)
                          .launchWa(phoneNo: phoneNo, text: message);
                    }),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
