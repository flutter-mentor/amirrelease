import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class NoInternetPatient extends StatelessWidget {
  const NoInternetPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Icon(
                      Icons.wifi_off_outlined,
                      color: Colors.grey,
                      size: 150,
                    ),
                    Text(
                      'No Internet Connection',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Don\'t worry you still can receive reminders notifications',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
