import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/layout/main_layout.dart';
import 'package:medicine_tracker/models/farmacy_model.dart';
import 'package:medicine_tracker/models/location_model.dart';
import 'package:medicine_tracker/models/meeting_model.dart';
import 'package:medicine_tracker/models/reminder_model.dart';
import 'package:medicine_tracker/models/intake_model.dart';
import 'package:medicine_tracker/models/medicine_model.dart';
import 'package:medicine_tracker/models/report_model.dart';
import 'package:medicine_tracker/network/local/cash_helper.dart';
import 'package:medicine_tracker/patient_layout/screens/relatives_screen/relatives_screen.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'dart:math' show cos, sqrt, asin;
import '../const/const.dart';
import '../helpers/dummy_notfict.dart';
import '../helpers/report_helper.dart';
import '../models/relatives_model.dart';
import '../models/update_reminder_model.dart';
import '../models/user_model.dart';
import '../patient_layout/screens/charts_screen/charts_screen.dart';
import '../patient_layout/screens/create_reminder_screen/add_reminder_details_screen/add_reminder_details_screen.dart';
import '../patient_layout/screens/create_reminder_screen/intakes_screen/intakes_screen.dart';
import '../patient_layout/screens/main_screen/main_screen.dart';
import '../patient_layout/screens/profile/profile_screen.dart';

class MedCubit extends Cubit<MedStates> {
  static MedCubit get(context) => BlocProvider.of(context);
  MedCubit() : super(MedInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lNAmeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController reminderMedNameController = TextEditingController();
  bool isPassword = true;
  bool isPatient = false;
  String obSecureText = 'Show';
  bool userLoginIn = true;
  int bottomNavBarIndex = 0;
  String selectedMedColor = '';
  void setSelectedMedColor(String color) {
    selectedMedColor = color;
    emit(SelectMedColor());
  }

  void changeBottomNavBar(int index) {
    bottomNavBarIndex = index;
    emit(ChangeBottomBar());
  }

  bool colorTaped = false;
  int? colorIndex;
  void setColorIndex({required int index}) {
    colorIndex = index;
    colorTaped = true;
    emit(ColorTapped());
  }

  bool patient = true;
  void notPatient(bool isPatient) {
    patient = isPatient;
    emit(ChangedAuthRules());
  }

  List<Widget> appScreens = [
    MainScreen(),
    ChartsScreen(),
    RelativesScreen(),
    ProfileScreen(),
  ];
  void changeAuthBehavior() {
    userLoginIn = !userLoginIn;
    emit(ChangeAuthBehavior());
  }

  int currentPageViewIndex = 0;
  void nestStep() {
    currentPageViewIndex++;
    emit(ChangedPageViewIndex());
  }

  void previousStep() {
    currentPageViewIndex--;
    emit(ChangedPageViewIndex());
  }

  String mediceneNAme = '';
  String freq = '';

  String notfictBody =
      'Please update_mypatient_reminder dose to notfiy relatives';
  List<Widget> stepsScreens = [
    AddReminderDetailsScreen(),
    SetIntakesScreen(),
  ];
  int reminderIdGenerator = 0;

  void removeIntake(int index) {
    intakes.removeAt(index);
    emit(RemovedIntakeDone());
  }

  int uniqueId() {
    int id = DateTime.now().hour +
        DateTime.now().minute +
        DateTime.now().second +
        DateTime.now().microsecond +
        DateTime.now().month +
        DateTime.now().day;
    return id;
  }

  void saveReminder({
    required String medName,
  }) {
    emit(AddReminderLoading());
    myReminders = [];
    int id = uniqueId();
    var idd = id;
    List notfictId = [];
    for (int i = 0; i < intakes.length; i++) {
      NotificationApi.showSchadNotfictDaily(
          id: idd += i,
          title: '${medName} intake time is now ',
          body: 'You need ${intakes[i].dose} pills now',
          payload: id.toString(),
          h: intakes[i].time.hour,
          m: intakes[i].time.minute,
          s: 0);
      notfictId.add(idd + 1);
    }
    ReminderModel reminderModel = ReminderModel(
        uid: uId!,
        color: selectedMedColor,
        notfictIds: notfictId,
        routine: intakes.map((e) {
          return {'time': e.time, 'dose': e.dose, 'took': e.took};
        }).toList(),
        medName: medName,
        intakes: intakes.map((e) {
          return {'time': e.time, 'dose': e.dose, 'took': e.took};
        }).toList(),
        hint: notfictBody,
        createdAt: Timestamp.now(),
        id: id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(id.toString())
        .set(reminderModel.toMap())
        .then((value) {
      currentPageViewIndex = 0;
      getMyAllReminders();
      emit(AddReminderDone());
    }).catchError((error) {
      emit(AddReminderError(error.toString()));
      print(error.toString());
    });
  }

  DateTime intakeTime = DateTime.now();
  void chooseDateTime(DateTime choosed) {
    intakeTime = choosed;
    emit(ChoosedDateTime());
  }

  void changePAsswordBehavior() {
    isPassword = !isPassword;
    if (isPassword == false) {
      obSecureText = 'Hide';
    } else if (isPassword == true) {
      obSecureText = 'Show';
    }
    emit(ChangePasswordBehavior());
  }

  List<IntakeModel> intakes = [];

  void addIntakes({
    required DateTime time,
    required double dose,
  }) {
    intakes.add(IntakeModel(time: time, dose: dose, took: false));
    emit(AddIntakesDone());
  }

  String errorMessage = '';
  void login({required String email, required String password}) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginDone(value.user!.uid));
      uId = value.user!.uid;
    }).catchError((error) {
      emit(LoginError(error.toString()));
      switch (error.code) {
        case 'invalid-email':
          errorMessage = "Incorrect email";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password";
          break;
        case "too-many-requests":
          errorMessage = "Something went wrong , try again";
          break;

        default:
          errorMessage = "Something went wrong , try again";
      }
    });
  }

  void createUser({
    required String name,
    required String eMail,
    required String uId,
    required String phone,
    required String lName,
  }) {
    emit(CreateUserLoading());
    UserModel userModel = UserModel(
      profilePic: '',
      name: name,
      phone: phone,
      isPatient: patient,
      eMail: eMail,
      uId: uId,
      lastname: lName,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(CreateUserError(error.toString()));
    });
  }

  UserModel? userModel;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data().toString());
      emit(GetUserDone());
    }).catchError((error) {
      emit(GetUserError(error.toString()));
      print(error.toString());
    });
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String lName,
  }) {
    emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        lName: lName,
        phone: phone,
        eMail: email,
        uId: value.user!.uid,
      );
      emit(CreateUserDone(value.user!.uid));
    }).catchError((error) {
      emit(SignUpError(error.toString()));

      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "Email already in use";
          break;
        case "invalid-email":
          errorMessage = "Incorrect E-mail";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password";
          break;
        case "too-many-requests":
          errorMessage = "Something went wrong , try again";
          break;

        default:
          errorMessage = "Something went wrong , try again";
          print(error.code.toString());
      }
    });
  }

  void addMedicine() {
    MedicineModel medicineModel = MedicineModel(
        describtion: medDesc,
        name: 'paramol',
        effective: 'paracetamol',
        img:
            'https://www.al-agzakhana.com/wp-content/uploads/2017/12/Bi-Alcofan-Tablets.jpg',
        initPrice: 12.5);
    FirebaseFirestore.instance
        .collection('medicines')
        .add(medicineModel.toMap())
        .then((value) {
      emit(AddMedDone());
    }).catchError((error) {
      emit(AddMedError(error.toString()));
    });
  }

  List<MedicineModel> medicineList = [];
  void getMedicines() {
    FirebaseFirestore.instance
        .collection('medicines')
        //streams
        .snapshots()
        .listen((event) {
      medicineList = [];
      event.docs.forEach((element) {
        medicineList.add(MedicineModel.fromJson(element.data()));
      });
      emit(GetMedDone());
    });
  }

  void searchMedicine({
    required String medName,
    required List<MedicineModel> medList,
  }) {
    getMedicines();
    medList = medicineList.where((element) {
      return element.name.contains(medName);
    }).toList();
    emit(FoundMedicine());
  }

  List<ReminderModel> myReminders = [];

  void getMyAllReminders() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        myReminders.add(ReminderModel.fromJson(element.data()));
      });
      emit(GetDueReminderDone());
    }).catchError((error) {
      emit(GetDueReminderError(error.toString()));
      print(error.toString());
    });
  }

  List<ReminderModel> dueReminders = [];
  void getMyRelatives() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      dueReminders.add(ReminderModel.fromJson(value.data()!));
    }).catchError((error) {});
  }

  List<UserModel> allUsers = [];
  List<UserModel> foundUsers = [];
  void getAllUsers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        allUsers.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersDone());
    }).catchError((error) {
      emit(GetAllUsersError(error.toString()));
    });
  }

  List<double> pillsCount = [];
  void searchForRelative(String search) {
    foundUsers = allUsers.where((element) {
      return element.phone.contains(search);
    }).toList();
    // if (search.isEmpty) {
    //   foundUsers = [];
    // }
    emit(FoundRelative());
  }

  void generatePillsCount() {
    for (double pill = 0; pill <= 20.0; pill += 0.25) {
      if (pill != 0.0) {
        pillsCount.add(pill);
      }
    }
  }

  List<ReminderModel> dailyRoutine = [];
  void updateRoutine() {
    //HARD CODED METHOD//
    // method should have been running in a cloud function from provided backend
    // but we made it as a hardcoded method as no backend developer in the team to trigger such a method
    // but it achieve the main goal which is updating the patient daily routine immediately when patient opens the app
    //from terminated state or stream condition is done
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('reminders')
            .doc(element.id);
        if (DateTime.now().month > element.data()['createdAt'].toDate().month &&
            DateTime.now().day > element.data()['createdAt'].toDate().day) {
          docRef.update({'intakes': element.data()['routine']});
        }
      });
      emit(UpdateRoutineDone());
    }).catchError((error) {
      emit(UpdateRoutineError(error.toString()));
    });
  }

  void updateIntake({
    required String id,
    required List updatedList,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(id)
        .update({'intakes': updatedList}).then((value) {
      myReminders = [];
      getMyAllReminders();
      emit(IntakeUpdateDone());
    }).catchError((error) {
      emit(IntakeUpdateError(error.toString()));
    });
  }

  void requestRelative(
      {required String relativeId,
      required String relativeName,
      required String relativeLname,
      required String relativePhone,
      required String relativeMail}) {
    RequestModel mine = RequestModel(
      uid: uId!,
      hasAccept: false,
      name: userModel!.name,
      lastname: userModel!.lastname,
      eMail: userModel!.eMail,
      phone: userModel!.phone,
    );
    RequestModel? relative = RequestModel(
        uid: relativeId,
        hasAccept: false,
        lastname: relativeLname,
        name: relativeName,
        eMail: relativeMail,
        phone: relativePhone);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('relatives')
        .doc(relativeId)
        .set(relative.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(relativeId)
          .collection('relatives')
          .doc(uId)
          .set(mine.toMap());
      emit(SendRequestDone());
      relatives = [];
      getRelatives();
    }).catchError((error) {
      SendRequestError(error.toString());
    });
  }

  List<RequestModel> relatives = [];

  void getRelatives() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('relatives')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        relatives.add(RequestModel.fromJson(element.data()));
      });
    }).then((value) {
      emit(GetMyRelativesDone());
    }).catchError((error) {
      emit(GetMyRelativesError(error.toString()));
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

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      currentPageViewIndex = 0;
      intakes = [];
      uId = null;
      userModel = null;
      myReports = [];
      myReminders = [];
      relatives = [];

      CacheHelper.removeData(key: 'uid');
      emit(SignOutDone());
    }).catchError((error) {
      emit(SignOutError(error));
    });
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  Position? patientPostition;

  void locationUpdatesStream() {
    checkPermssions();
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      patientPostition = position;
      if (patientPostition != null) {
        setMyLocation(
            lat: patientPostition!.latitude, long: patientPostition!.longitude);
      }
      emit(ListenToLocationUpdates());
    });
  }

  void setMyLocation({
    required double lat,
    required double long,
  }) {
    LocationModel locationModel = LocationModel(lat: lat, long: long);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('location')
        .doc(uId)
        .set(locationModel.toMap())
        .then((value) {
      updateLocationOnDb();
    }).catchError((error) {
      UpdatedLocationError(error.toString());
    });
  }

  void updateLocationOnDb() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('location')
        .doc(uId)
        .update({
      'lat': patientPostition!.latitude,
      'long': patientPostition!.longitude
    }).then((value) {
      emit(UpdatedLocationDone());
    }).catchError((error) {
      emit(UpdatedLocationError(error.toString()));
      print(error.toString());
    });
  }

  bool? enabled;
  LocationPermission? loPermsioon;
  Future<void> checkPermssions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      emit(DeviceLocationDisabled());
    } // user disables location services all
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        emit(UserDeniedAppLocationAtTime());
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(USerDeniedAppLocationForever());
    }
  }

  void updateUserData({
    required Map<String, dynamic> userMap,
  }) {
    emit(UpdateUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userMap)
        .then((value) {
      getUserData();
      emit(UpdateUserDataDone());
    }).catchError((error) {
      emit(UpdateUserDataError(error.toString()));
      print(error.toString());
    });
  }

  void resetMyReminder({
    required String reminderId,
  }) {
    var routine;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(reminderId)
        .get()
        .then((value) {
      routine = value.data()!['routine'];
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('reminders')
          .doc(reminderId)
          .update({'intakes': routine});
      myReminders = [];
      getMyAllReminders();
      emit(ResetReminderDone());
    }).catchError((error) {
      emit(ResetReminderError(error.toString()));
    });
  }

  void deleteReminder({
    required String reminderID,
    required List notfictList,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(reminderID)
        .delete()
        .then((value) {
      for (int i = 0; i < notfictList.length; i++) {
        NotificationApi.cancel(notfictList[i]);
      }
      myReminders = [];
      getMyAllReminders();
      emit(DeleteRelativeDone());
    }).catchError((error) {
      emit(DeleteReminderError(error.toString()));
    });
  }

  bool areWeconnectedToIneternt = true;
  void checkInternetStream() {
    StreamSubscription subscription =
        InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      areWeconnectedToIneternt = hasInternet;
      emit(InternetConenctionChanged());
    });
  }

  ReminderModel? dueReminderModel;
  void getDueReminder({
    required String reminderId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(reminderId)
        .snapshots()
        .listen((event) {
      dueReminderModel = ReminderModel.fromJson(event.data()!);
    });
    emit(GetDueReminderDone());
  }

  List<UpdateReminderModel> reminderUpdates = [];
  void getMyReminderUpdates() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('remindersUpdate')
        .snapshots()
        .listen((event) {
      reminderUpdates = [];
      event.docs.forEach((element) {
        reminderUpdates.add(UpdateReminderModel.fromJson(element.data()));
      });
      emit(GetMyReminderUpdatesDone());
    });
  }

  void saveNewReminder({
    required UpdateReminderModel updateReminderModel,
  }) {
    List notfictIds = [];
    for (int i = 0; i < updateReminderModel.intakes.length; i++) {
      notfictIds.add(updateReminderModel.medId + i);
    }
    ReminderModel reminderModel = ReminderModel(
        uid: uId!,
        color: updateReminderModel.medColor,
        notfictIds: notfictIds,
        routine: updateReminderModel.intakes.map((e) {
          return {'dose': e['dose'], 'time': e['time'], 'took': e['took']};
        }).toList(),
        medName: updateReminderModel.medName,
        intakes: updateReminderModel.intakes.map((e) {
          return {'dose': e['dose'], 'time': e['time'], 'took': e['took']};
        }).toList(),
        hint: notfictBody,
        createdAt: Timestamp.now(),
        id: updateReminderModel.medId);
    swapReminder(
        updateReminderModel: updateReminderModel, reminderModel: reminderModel);
    deleteOldReminderNotfict(
        notfictids: oldNotfictList(updateReminderModel.medId.toString()));
    deleteUpdateNotification(
        updateReminderId: updateReminderModel.medId.toString());
    for (int i = 0; i < updateReminderModel.intakes.length; i++) {
      NotificationApi.showSchadNotfictDaily(
          id: notfictIds[i],
          title: '${updateReminderModel.medName} intake time now',
          body: '${updateReminderModel.intakes[i]['dose']} pills now ',
          payload: updateReminderModel.medId.toString(),
          h: updateReminderModel.intakes[i]['time'].toDate().hour,
          m: updateReminderModel.intakes[i]['time'].toDate().minute,
          s: 0);
    }
    emit(SaveNewReminderDone());
  }

  void swapReminder({
    required UpdateReminderModel updateReminderModel,
    required ReminderModel reminderModel,
  }) {
    final String medID = updateReminderModel.medId.toString();
    print(medID);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(updateReminderModel.medId.toString())
        .update(reminderModel.toMap())
        .then((value) {
      emit(SwapReminderDone());
      myReminders = [];
      getMyAllReminders();
      addReport();
    }).catchError((error) {
      emit(SwapReminderError(error.toString()));
      print(error.toString());
    });
  }

  void deleteOldReminderNotfict({required List notfictids}) {
    for (int i = 0; i < notfictids.length; i++) {
      NotificationApi.cancel(notfictids[i]);
    }
  }

  List oldNotfictList(String reminderId) {
    List notifctids = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(reminderId)
        .get()
        .then((value) {
      notifctids = value['notfictIds'];
    }).catchError((error) {
      print('An Error ${error.toString()}');
    });
    return notifctids;
  }

  void deleteUpdateNotification({required String updateReminderId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('remindersUpdate')
        .doc(updateReminderId)
        .delete()
        .then((value) {
      emit(DeleteUpdateNotfictDone());
    }).catchError((error) {
      DeleteUpdateNotfictError(error.toString());
    });
  }

  void addReport() {
    ReportModel reportModel = ReportModel(
        id: '${DateFormat('EEEE').format(DateTime.now())}',
        reminders: myReminders.map((e) {
          return {
            'id': e.id,
            'uid': e.uid,
            'notfictIds': e.notfictIds,
            'medName': e.medName,
            'color': e.color,
            'routine': e.routine,
            'intakes': e.intakes,
            'createdAt': e.createdAt,
            'hint': e.hint
          };
        }).toList());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reports')
        .doc('${DateFormat('EEEE').format(DateTime.now())}')
        .set(reportModel.toMap())
        .then((value) {
      emit(AddReportDone());
    }).catchError((error) {
      emit(AddReportErrorr(error.toString()));
    });
  }

  List<ReportModel> myReports = [];
  void getAllReports() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reports')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        myReports.add(ReportModel.fromJson(element.data()));
      });
      emit(GetReporsDone());
    }).catchError((error) {
      emit(GetReportsError(error.toString()));
      print(error.toString());
    });
  }

  List<FarmacyModel> allFarmacies = [];
  void getAllFarmacies() {
    FirebaseFirestore.instance.collection('pharmacies').get().then((value) {
      value.docs.forEach((element) {
        allFarmacies.add(FarmacyModel.fromJson(element.data()));
      });
      emit(GetFarmaciesDone());
    }).catchError((error) {
      emit(GetFarmaciesError(error.toString()));
      print(error.toString());
    });
  }

  void addPharmacy() {
    FarmacyModel farmacyModel = FarmacyModel(
        farmactLogo: 'https://www.19011.tel/logo/19011.png',
        farmacyName: '19011',
        farmacyPhone: '19011');
    FirebaseFirestore.instance
        .collection('pharmacies')
        .add(farmacyModel.toMap())
        .then((value) {
      allFarmacies = [];
      getAllFarmacies();
      emit(AddFarmacyDone());
    }).catchError((error) {
      emit(AddFarmacyError(error.toString()));
    });
  }

  List<ReportItem> reportITemList = [];
  void setAccountType({required BuildContext context}) {
    FirebaseFirestore.instance.collection('users').doc(uId).set({
      'isPatient': patient,
      'name': userModel!.name,
      'lastname': userModel!.lastname,
      'phone': userModel!.phone,
      'profilePic': userModel!.profilePic,
      'uId': userModel!.uId,
      'eMail': userModel!.eMail,
    }).then((value) {
      getUserData();
      navigateAndFinish(context, MainLayout());
      emit(SetAccountAuthDone());
    }).catchError((error) {
      emit(SetAccountAuthError(error.toString()));
      print(error.toString());
    });
  }

  PlatformFile? pickedFile;
  Future pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    } else {
      pickedFile = result.files.first;
    }
    emit(ChangedProfilePic());
  }

  UploadTask? uploadTask;
  Future uploadPhoto() async {
    emit(UploadPhotoLoading());
    final path = 'files/${pickedFile!.name}/';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snap = await uploadTask!.whenComplete(() {});
    final urlDonwload = await snap.ref.getDownloadURL();
    print(urlDonwload);
    addProfilePic(urlDonwload);
    getUserData();
  }

  void addProfilePic(String img) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'profilePic': img}).then((value) {
      emit(UploadPhotoDone());
      pickedFile = null;
    }).catchError((error) {
      emit(UploadPhotoError(error.toString()));
      print(error.toString());
    });
  }

  //   Map<String, dynamic> userData = {
  //     'eMail': emailController.text,
  //     'profilePic': '${url}',
  //     'name': userModel!.name,
  //     'lastname': userModel!.lastname,
  //     'phone': userModel!.phone,
  //     'isPatient': userModel!.isPatient,
  //     'uId': userModel!.uId,
  //   };
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .set(userData)
  //       .then((value) {
  //     getUserData();
  //     emit(UploadPhotoDone());
  //   }).catchError((error) {
  //     emit(UploadPhotoError(error.toString()));
  //   });
  // }
  void addMeeting({
    required String docName,
    required String reaseon,
    required DateTime meetingAt,
  }) {
    MeetingModel meetingModel = MeetingModel(
        uid: uId!,
        id: '${uId}${DateTime.now()}',
        doctorName: docName,
        meetingAt: Timestamp.fromDate(meetingAt),
        cauuz: reaseon);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meetings')
        .doc(meetingModel.id)
        .set(meetingModel.toMap())
        .then((value) {
      DummyNotfict.showSchadNotfict(
          id: DateTime.now().day,
          title: 'Your Meeting with ${docName} is now ',
          body: 'don\'t forget your meeting ',
          // payload: '${meetingModel.id}',
          time: meetingAt);
      emit(AddMeetingDone());
    }).catchError((error) {
      emit(AddMeetingError(error.toString()));
    });
  }

  List<MeetingModel> meetinsList = [];
  void getAllMeetings() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meetings')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        meetinsList.add(MeetingModel.fromJson(element.data()));
      });
      emit(GetMeetingsDone());
    }).catchError((error) {
      emit(GetMeetingsError(error.toString()));
      print(error.toString());
    });
  }

  void deleteMeeting(String meetingId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meetings')
        .doc(meetingId)
        .delete()
        .then((value) {
      meetinsList = [];
      getAllMeetings();
      emit(GetMeetingsDone());
    }).catchError((error) {
      GetMeetingsError(error.toString());
    });
  }

  String? passwordVerifyMessage;
  void resetPassword(String email) {
    emit(SendRecoveryLinkLoading());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(SendRecoveryLinkDone());
    }).catchError((error) {
      emit(SendRecoveryLinkError(error.toString()));
      print(error.code);
      switch (error.code) {
        case 'invalid-email':
          passwordVerifyMessage = 'Wrong E-mail';
          break;
        case 'missing-email':
          passwordVerifyMessage = 'Type E-mail';
          break;
        case 'user-not-found':
          passwordVerifyMessage = 'No E-mail ';
          break;
        default:
          passwordVerifyMessage = 'Confirm E-mail';
      }
    });
  }
}
