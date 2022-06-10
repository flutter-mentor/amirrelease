import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/patient_layout/location_enabled_widget.dart';
import 'package:medicine_tracker/patient_layout/screens/due_reminder_screen/due_reminder_screen.dart';
import 'package:medicine_tracker/patient_layout/screens/main_screen/widgets/data_widget.dart';
import 'package:medicine_tracker/patient_layout/screens/main_screen/widgets/header_widget.dart';
import 'package:medicine_tracker/patient_layout/screens/my_location_screen/my_location_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../componenets/componenets.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/adabtive_simple_dialogue.dart';
import '../../../global_widgets/primary_button.dart';
import '../create_reminder_screen/create_reminder_screen.dart';
import '../medicine_finder/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init(initSchudealed: true);
    NotificationApi.initializetimezone();
    listenNotifict();
  }

  void listenNotifict() {
    NotificationApi.onNotfications.stream.listen(onClickNotfict);
  }

  void onClickNotfict(String? payload) {
    MedCubit.get(context).getDueReminder(reminderId: payload!);
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        context: context,
        builder: (context) {
          setState(() {
            MedCubit.get(context).getDueReminder(reminderId: payload);
          });
          return DueReminderWidget(
            reminderId: payload,
            // pyload: payload,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          centerTitle: false,
          title: Text(
            'Medication tracker',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AppColors.primColor),
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                size: 20,
              ),
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
            ),
            IconButton(
              icon: Icon(
                Icons.pin_drop_outlined,
                size: 20,
              ),
              onPressed: () {
                launch(
                  'https://www.google.com/maps/search/?api=1&query=${MedCubit.get(context).patientPostition!.latitude},${MedCubit.get(context).patientPostition!.latitude}',
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                navigateTo(context, CreateReminderScreen());
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PatientLocationWidget(),
              const SizedBox(
                height: 20,
              ),
              HeaderWidget(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 4,
                child: DataWidget(),
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is UserDeniedAppLocationAtTime ||
          state is USerDeniedAppLocationForever) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Column(
                children: [
                  Text(
                    'Enable location',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'in order to help relatives to find you',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                      text: 'Enable',
                      width: double.infinity,
                      height: 50,
                      color: AppColors.primColor,
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      }),
                ],
              ));
            });
      } else if (state is DeviceLocationDisabled) {
        showDialog(
            context: context,
            builder: (context) {
              return AdabtiveSimpleDialogue(
                  title: Column(
                children: [
                  Text(
                    'Enable location',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'in order to help relatives to find you',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                      text: 'Enable',
                      width: double.infinity,
                      height: 50,
                      color: AppColors.primColor,
                      onPressed: () async {
                        await Geolocator.openLocationSettings();
                      }),
                ],
              ));
            });
      }
    });
  }
}
