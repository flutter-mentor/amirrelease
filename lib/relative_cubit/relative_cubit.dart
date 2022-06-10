import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/auth/auth_screen.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/models/reminder_model.dart';
import 'package:medicine_tracker/models/update_reminder_model.dart';
import 'package:medicine_tracker/network/local/cash_helper.dart';
import 'package:medicine_tracker/relative_cubit/realtive_states.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../const/const.dart';
import '../helpers/report_helper.dart';
import '../models/intake_model.dart';
import '../models/relatives_model.dart';
import '../models/report_model.dart';
import '../models/user_model.dart';
import '../relative_layout/screens/my_patients_screen/my_patients_screen.dart';
import '../relative_layout/screens/profile/relative_profile_Screen.dart';

class RelCubit extends Cubit<RelativeStates> {
  static RelCubit get(context) => BlocProvider.of(context);
  RelCubit() : super(RelativeInitState());
  void changeRelativeBottomLayout(int index) {
    bootmRelativeLayout = index;
    emit(ChangeRelativeBottomNavBar());
  }

  int bootmRelativeLayout = 0;
  List<Widget> relativeScreens = [
    MyPatientsScreen(),
    RelativeProfileScreen(),
  ];
  List<RequestModel> myPatients = [];
  void getAllPatients() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('relatives')
        .where('hasAccept', isEqualTo: true)
        .snapshots()
        .listen((event) {
      myPatients = [];
      event.docs.forEach((element) {
        myPatients.add(RequestModel.fromJson(element.data()));
      });
      emit(GetMyPatientsDone());
    });
  }

  List<ReminderModel> myPatintsReminder = [];
  List<ReportModel> myPatientReports = [];
  void getPatientActivity(String patientID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientID)
        .collection('reminders')
        .snapshots()
        .listen((event) {
      myPatintsReminder = [];
      event.docs.forEach((element) {
        myPatintsReminder.add(ReminderModel.fromJson(element.data()));
      });
      emit(GetMyPatientReminderDone());
    });
  }

  List<ReportItem> reportItemList = [];

  void getPaitientReport(String patientId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientId)
        .collection('reports')
        .snapshots()
        .listen((event) {
      myPatientReports = [];

      event.docs.forEach((element) {
        myPatientReports.add(ReportModel.fromJson(element.data()));
      });
      emit(GetPatientReportDone());
    });
  }

  UserModel? patientModel;

  void getPatientData({
    required String patientId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientId)
        .snapshots()
        .listen((event) {
      patientModel = UserModel.fromJson(event.data()!);
      emit(GetPatientDataDone());
    });
  }

  List<RequestModel> myRequests = [];

  void getActiveRequest() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('relatives')
        .where('hasAccept', isEqualTo: false)
        .snapshots()
        .listen((event) {
      myRequests = [];
      event.docs.forEach((element) {
        myRequests.add(RequestModel.fromJson(element.data()));
      });
      emit(GetMyPatientsDone());
    });
  }

  void acceptRequest({
    required String patientId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('relatives')
        .doc(patientId)
        .update({
      'hasAccept': true,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(patientId)
          .collection('relatives')
          .doc(uId)
          .update({
        'hasAccept': true,
      });
      emit(AcceptRequestDone());
    }).catchError((error) {
      emit(AcceptRequestError(error.toString()));
    });
  }

  void launchWa({
    required String phoneNo,
    required String text,
  }) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+20${phoneNo}',
      text: "${text}",
    );
    await launch('$link');
  }

  void getPatientLocation({
    required String patientId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientId)
        .collection('location')
        .doc(patientId)
        .get()
        .then((value) {
      launch(
          'https://www.google.com/maps/search/?api=1&query=${value.data()!['lat']},${value.data()!['long']}');
      emit(FetchedPatientLocationDone());
    }).catchError((error) {
      emit(FetchedPatientLocationError(error.toString()));
    });
  }

  void callPatient(String phone) {
    launch('tel:${phone}');
  }

  void waPatient({
    required String wa,
    required String quickMessage,
    required BuildContext context,
  }) {
    launchWa(phoneNo: wa, text: quickMessage);
  }

  void updateMyPatientIntake({
    required String reminderId,
    required String patientId,
    required List updatedList,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientId)
        .collection('reminders')
        .doc(reminderId)
        .update({'intakes': updatedList}).then((value) {
      myPatintsReminder = [];
      getPatientActivity(patientId);
      emit(UpdatedMyPatientIntakeDone());
    }).catchError((error) {
      emit(UpdatedMyPatientIntakeError(error.toString()));
    });
  }

  List<IntakeModel> intakes = [];
  String updatedMedName = '';
  String updateMedColor = '';
  int updatedMedId = 0;
  String updatedPatientId = '';
  List updatedMedNotfictList = [];
  void setUpdatedMedData(
      {required String medName,
      required String medDColor,
      required List oldIntakes,
      required int medId,
      required List notfictIdsList,
      required String patId}) {
    updatedMedName = medName;
    updateMedColor = medDColor;
    updatedPatientId = patId;
    updatedMedNotfictList = notfictIdsList;
    oldIntakes.forEach((element) {
      intakes.add(IntakeModel(
          time: element['time'].toDate(),
          dose: element['dose'],
          took: element['took']));
    });
    updatedMedId = medId;
    emit(SetUpdateMedicineData());
  }

  void addIntakes({
    required DateTime time,
    required double dose,
  }) {
    intakes.add(IntakeModel(time: time, dose: dose, took: false));
    emit(AddIntakeForPatient());
  }

  void removeIntake(int index) {
    intakes.removeAt(index);
    emit(RemoveIntakeForPatient());
  }

  List<double> pillsCount = [];

  void generatePillsCount() {
    for (double pill = 0; pill <= 20.0; pill += 0.25) {
      if (pill != 0.0) {
        pillsCount.add(pill);
      }
    }
  }

  void updateMyPatientReminder() {
    emit(SendUpdateNotfictLoading());
    UpdateReminderModel updateReminderModel = UpdateReminderModel(
        notfictIds: updatedMedNotfictList,
        intakes: intakes.map((e) {
          return {'took': e.took, 'time': e.time, 'dose': e.dose};
        }).toList(),
        medName: updatedMedName,
        medColor: updateMedColor,
        medId: updatedMedId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(updatedPatientId)
        .collection('remindersUpdate')
        .doc(updatedMedId.toString())
        .set(updateReminderModel.toMap())
        .then((value) {
      emit(SendUpdateNotfictDone());
    }).catchError((error) {
      emit(SendUpdateNotfictError(error.toString()));
      print(error.toString());
    });
  }

  void signOut({
    required BuildContext context,
  }) {
    FirebaseAuth.instance.signOut();
    uId = null;
    CacheHelper.removeData(key: 'uid');
    navigateAndFinish(context, AuthScreen());
  }
}
