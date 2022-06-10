import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAdabtiveSpinner extends StatelessWidget {
  bool isIos;
  CustomAdabtiveSpinner({
    Key? key,
    required this.isIos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isIos == true)
      return Center(child: CupertinoActivityIndicator());
    else
      return Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
  }
}
