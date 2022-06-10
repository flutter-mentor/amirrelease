import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CustomPickerWidget extends StatelessWidget {
  const CustomPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              height: 300,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      children: MedCubit.get(context).pillsCount.map((e) {
                        return Text('${e.toString()} Pills');
                      }).toList(),
                      itemExtent: 55,
                      onSelectedItemChanged: (v) {},
                      useMagnifier: true,
                    ),
                  ),
                  CupertinoButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
