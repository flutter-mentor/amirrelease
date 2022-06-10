import 'package:flutter/material.dart';
import '../../../../const/const.dart';

class ProfileActionWidget extends StatelessWidget {
  String text;
  GestureTapCallback onTap;
  ProfileActionWidget({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${text}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.primColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
