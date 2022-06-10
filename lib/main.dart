import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medicine_tracker/auth/auth_screen.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/custom_animtaed_splash_screen/animated_splash_screen_widgt.dart';
import 'package:medicine_tracker/global_widgets/choose_type_screen.dart';
import 'package:medicine_tracker/layout/main_layout.dart';
import 'package:medicine_tracker/relative_cubit/relative_cubit.dart';
import 'const/myBlocObserver.dart';
import 'network/local/cash_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uid');
  initializeDateFormatting('en');
  chosoedType = CacheHelper.getBoolean(key: 'type');
  Widget startWidget;
  print(uId);
  print(chosoedType);

  if (uId != null && chosoedType != null) {
    startWidget = MainLayout();
  } else if (uId != null && chosoedType == null) {
    startWidget = ChooseTypeScreen();
  } else if (uId == null && chosoedType == null) {
    startWidget = AuthScreen();
  } else {
    startWidget = AuthScreen();
  }
  runApp(MedicationTracker(
    startWidget: startWidget,
  ));
}

class MedicationTracker extends StatelessWidget {
  Widget startWidget;
  MedicationTracker({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => MedCubit()
              ..getUserData()
              ..getAllUsers()
              ..generatePillsCount()
              ..getMyAllReminders()
              ..getRelatives()
              ..checkPermssions()
              ..locationUpdatesStream()
              ..checkInternetStream()
              ..updateRoutine()
              ..getAllFarmacies()
              ..getAllReports()
              ..getAllMeetings()),
        BlocProvider(
            create: (BuildContext context) => RelCubit()
              ..getAllPatients()
              ..generatePillsCount())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medication Tracker',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AppColors.primColor,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              titleTextStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            textTheme: TextTheme(
              headline1: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0,
                fontSize: 24,
              ),
              headline2: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                letterSpacing: 0.15,
                color: Colors.black,
              ),
              subtitle1: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
              bodyText1: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
              bodyText2: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
              caption: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.black,
              ),
              button: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
              ),
              overline: GoogleFonts.nunito(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primColor),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.primColor,
                textStyle: GoogleFonts.nunito(),
              ),
            ),
          ),
          home: CustomAnimatedSplash(startWidget)),
    );
  }
}
