import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../global_widgets/adabtive_simple_dialogue.dart';
import '../global_widgets/adabtive_spinnerr.dart';
import '../global_widgets/custom_text_filled.dart';
import '../global_widgets/primary_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Forget password'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  CustomTextFilled(
                      label: 'E-mail',
                      readOnly: false,
                      height: 45,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ' E-mail is required';
                        }
                      },
                      isPasword: false,
                      controller: emailController),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is SendRecoveryLinkLoading)
                    CustomAdabtiveSpinner(isIos: Platform.isIOS),
                  if (state is! SendRecoveryLinkLoading)
                    PrimaryButton(
                        text: 'Send reset password instructions',
                        width: double.infinity,
                        height: 45,
                        color: AppColors.primColor,
                        onPressed: () {
                          MedCubit.get(context)
                              .resetPassword(emailController.text.trim());
                        })
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SendRecoveryLinkError) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Text(MedCubit.get(context).passwordVerifyMessage!));
            });
      }
      if (state is SendRecoveryLinkDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Text('Password reset email sent '));
            });
      }
    });
  }
}
