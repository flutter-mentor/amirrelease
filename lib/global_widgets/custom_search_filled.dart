import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CustomSearchBar extends StatefulWidget {
  ValueChanged<String> onChange;
  String placeHolder;
  CustomSearchBar({
    Key? key,
    required this.placeHolder,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: TextFormField(
              onChanged: widget.onChange,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: '${widget.placeHolder}',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
