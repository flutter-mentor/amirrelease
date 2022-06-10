import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdabtiveSimpleDialogue extends StatelessWidget {
  Widget title;
  AdabtiveSimpleDialogue({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS == false) {
      return SimpleDialog(
        title: title,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'))
        ],
      );
    } else
      return CupertinoAlertDialog(
        title: title,
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Ok',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
  }
}
