// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../cubit/cubit.dart';
// import '../../cubit/states.dart';
//
// class UpdateIntakeScreen extends StatelessWidget {
//   String reminderId;
//
//   UpdateIntakeScreen({Key? key, required this.reminderId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MedCubit, MedStates>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               title: TextButton(
//                 onPressed: () {
//                   print(reminderId);
//                 },
//                 child: Text('asd'),
//               ),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                     child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     var reminder = MedCubit.get(context).dueReminders[index];
//                     return Column(
//                       children: [
//                         Text(reminder.medName),
//                         Text(MedCubit.get(context)
//                             .dueReminders
//                             .length
//                             .toString())
//                       ],
//                     );
//                   },
//                   itemCount: MedCubit.get(context).dueReminders.length,
//                 ))
//               ],
//             ),
//           );
//         },
//         listener: (context, state) {});
//   }
// }
