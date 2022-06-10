import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdabtiveDialogue extends StatelessWidget {
  VoidCallback yesFunction;
  BuildContext context;
  String title;
  String yesText;
  String subtitle;
  AdabtiveDialogue({
    Key? key,
    required this.context,
    required this.title,
    required this.subtitle,
    required this.yesFunction,
    required this.yesText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS == true) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText2!,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Cancel',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: CupertinoColors.activeBlue),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              yesText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: CupertinoColors.destructiveRed),
            ),
            onPressed: yesFunction,
          ),
        ],
      );
    } else
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        content: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 50),
        alignment: AlignmentDirectional.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: yesFunction,
            child: Text(
              yesText,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
        title: Text(
          title,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      );
  }
}
