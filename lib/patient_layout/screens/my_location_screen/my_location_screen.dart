import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class MyLocationScreen extends StatelessWidget {
  const MyLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text('My Location'),
            ),
            body: WebView(
              initialUrl:
                  'https://www.google.com/maps/search/?api=1&query=${MedCubit.get(context).patientPostition!.latitude},${MedCubit.get(context).patientPostition!.latitude}',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          );
        },
        listener: (context, state) {});
  }
}
