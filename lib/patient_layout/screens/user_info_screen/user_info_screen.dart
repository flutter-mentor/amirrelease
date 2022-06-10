import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/adabtive_simple_dialogue.dart';
import '../../../global_widgets/custom_text_filled.dart';
import '../../../global_widgets/primary_button.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =
        TextEditingController(text: MedCubit.get(context).userModel!.eMail);
    var firstNameController =
        TextEditingController(text: MedCubit.get(context).userModel!.name);
    var lastNameController =
        TextEditingController(text: MedCubit.get(context).userModel!.lastname);
    var phoneNoController =
        TextEditingController(text: MedCubit.get(context).userModel!.phone);
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('User info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MedCubit.get(context).userModel!.profilePic.isEmpty
                    ? buildOfflinePic(context)
                    : buildMyLivePic(context: context),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFilled(
                    label: '',
                    readOnly: true,
                    isPasword: false,
                    height: 40,
                    controller: emailController,
                    validator: (val) {}),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFilled(
                    label: '',
                    readOnly: false,
                    isPasword: false,
                    height: 40,
                    controller: firstNameController,
                    validator: (val) {}),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFilled(
                    label: '',
                    readOnly: false,
                    isPasword: false,
                    height: 40,
                    controller: lastNameController,
                    validator: (val) {}),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFilled(
                    label: '',
                    readOnly: false,
                    isPasword: false,
                    height: 40,
                    controller: phoneNoController,
                    validator: (val) {}),
                const SizedBox(
                  height: 16,
                ),
                if (state is UpdateUserLoading)
                  LottieBuilder.asset(
                    'assets/loading.json',
                    width: 50,
                  ),
                if (state is! UpdateUserLoading)
                  PrimaryButton(
                      text: 'Update info',
                      width: double.infinity,
                      color: AppColors.primColor,
                      height: 50,
                      onPressed: () {
                        Map<String, dynamic> userData = {
                          'eMail': emailController.text,
                          'profilePic':
                              '${MedCubit.get(context).userModel!.profilePic}',
                          'name': firstNameController.text,
                          'lastname': lastNameController.text,
                          'phone': phoneNoController.text,
                          'isPatient':
                              MedCubit.get(context).userModel!.isPatient,
                          'uId': MedCubit.get(context).userModel!.uId,
                        };

                        MedCubit.get(context).updateUserData(userMap: userData);
                      }),
                const SizedBox(
                  height: 20,
                ),
                if (state is UploadPhotoLoading)
                  LottieBuilder.asset(
                    'assets/loading.json',
                    width: 50,
                  ),
                if (state is! UploadPhotoLoading)
                  PrimaryButton(
                      text: 'Upload photo',
                      width: double.infinity,
                      color: AppColors.primColor,
                      height: 50,
                      onPressed: () {
                        MedCubit.get(context).uploadPhoto();
                      }),
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is UploadPhotoDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(title: Text('Image Uploaded'));
            });
      }
      if (state is UpdateUserDataDone) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(title: Text('Data updated'));
            });
      }
    });
  }

  Widget buildMyLivePic({
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        MedCubit.get(context).pickImage();
      },
      child: MedCubit.get(context).pickedFile == null
          ? Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(20),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '${MedCubit.get(context).userModel!.profilePic}')),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: Image.file(
                  File(
                    MedCubit.get(context).pickedFile!.path!,
                  ),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
    );
  }

  Widget buildOfflinePic(context) {
    return GestureDetector(
      onTap: () {
        MedCubit.get(context).pickImage();
      },
      child: MedCubit.get(context).pickedFile == null
          ? CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Icon(
                Icons.image_outlined,
                size: 50,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: Image.file(
                  File(
                    MedCubit.get(context).pickedFile!.path!,
                  ),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
    );
  }
}
