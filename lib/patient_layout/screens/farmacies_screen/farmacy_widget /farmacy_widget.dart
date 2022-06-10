import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/models/farmacy_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../const/const.dart';
import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../../../global_widgets/primary_button.dart';

class FarmacyWidget extends StatelessWidget {
  FarmacyModel farmacy;
  FarmacyWidget({Key? key, required this.farmacy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        farmacy.farmactLogo,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          farmacy.farmacyName,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // Text(
                        //   'Al Tagmoaa Al Khames',
                        //   style: Theme.of(context).textTheme.caption,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                            icon: Icons.call,
                            iconColor: Colors.white,
                            text: 'Contact',
                            color: AppColors.primColor,
                            width: 120,
                            height: 35,
                            onPressed: () {
                              launch('tel:${farmacy.farmacyPhone}');
                            }),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
