import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/global_widgets/primary_button.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      RelCubit.get(context).getActiveRequest();
      return BlocConsumer<RelCubit, RelativeStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('My requests'),
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  final request = RelCubit.get(context).myRequests[index];
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.primColor.withOpacity(0.3),
                              foregroundColor: Colors.black,
                              child: Text(
                                firstLetter(
                                  request.name,
                                ),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${request.name} ${request.lastname}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Sent you a relative request',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Row(
                                  children: [
                                    PrimaryButton(
                                        text: 'Accept',
                                        width: 100,
                                        color: AppColors.primColor,
                                        height: 30,
                                        onPressed: () {
                                          RelCubit.get(context).acceptRequest(
                                              patientId: request.uid);
                                        }),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    PrimaryButton(
                                        text: 'Decline',
                                        width: 100,
                                        color: Colors.red,
                                        height: 30,
                                        onPressed: () {}),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: RelCubit.get(context).myRequests.length,
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
