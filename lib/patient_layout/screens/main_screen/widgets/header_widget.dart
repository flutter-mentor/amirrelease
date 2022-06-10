import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Text(
            MedCubit.get(context).userModel != null
                ? 'Hello , ${MedCubit.get(context).userModel!.name} get well soon'
                : 'Hello , Get well soon',
            style: Theme.of(context).textTheme.subtitle1,
          );
        },
        listener: (context, state) {});
  }
}
