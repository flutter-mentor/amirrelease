import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';

import '../const/const.dart';

class CustomTextFilled extends StatelessWidget {
  String label;
  bool isPasword;
  Widget? suffix;
  double height;
  ValueChanged<String>? onChange;
  bool readOnly;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboard;

  TextEditingController controller;
  FormFieldValidator<String>? validator;
  CustomTextFilled({
    Key? key,
    required this.label,
    this.inputFormatters,
    this.onChange,
    required this.readOnly,
    required this.isPasword,
    this.keyboard,
    required this.height,
    this.suffix,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            // color: AppColors.greyColor.withOpacity(0.5),
            width: double.infinity,
            height: height,
            child: TextFormField(
              onChanged: onChange,
              readOnly: readOnly,
              keyboardType: keyboard,
              controller: controller,
              style: Theme.of(context).textTheme.bodyText2,
              inputFormatters: inputFormatters,
              obscureText: isPasword,
              validator: validator,
              cursorColor: AppColors.primColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                // border: InputBorder.none,
                suffixIcon: suffix,
                hintText: '${label}',
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black, width: 0.4),
                // ),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(
                //   color: Colors.grey,
                //   width: 0.2,
                // )),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.grey),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
