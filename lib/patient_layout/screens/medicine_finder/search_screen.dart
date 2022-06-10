import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../global_widgets/custom_search_filled.dart';
import '../../../global_widgets/medicine_widget.dart';
import '../../../models/medicine_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MedicineModel> medList = [];
  List<MedicineModel> synonmsList = [];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MedCubit.get(context).getMedicines();

      return BlocConsumer<MedCubit, MedStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Medicine finder',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomSearchBar(
                          placeHolder: 'Type medicine name',
                          onChange: (v) {
                            setState(() {
                              medList = MedCubit.get(context)
                                  .medicineList
                                  .where((element) {
                                    return element.name.contains(v);
                                  })
                                  .toSet()
                                  .toList();

                              print(medList.length);
                              if (v.isEmpty) {
                                medList = [];
                                synonmsList = [];
                              }
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          var synonom = medList[index].effective;

                          synonmsList = MedCubit.get(context)
                              .medicineList
                              .where((element) {
                            return element.effective.contains(synonom) &&
                                element.name != medList[index].name;
                          }).toList();
                          return MedicineWidget(model: medList[index]);
                        },
                        itemCount: medList.length,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      synonmsList.isEmpty
                          ? SizedBox()
                          : Text(
                              'Same active substance',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: synonmsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  width: 340,
                                  child: MedicineWidget(
                                      model: synonmsList[index]));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
