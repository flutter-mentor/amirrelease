import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  String text;
  double height;
  double width;
  IconData? icon;
  Color? color;
  Color? iconColor;

  GestureTapCallback? onPressed;
  PrimaryButton({
    Key? key,
    required this.text,
    this.color,
    this.iconColor,
    this.icon,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        disabledColor: Colors.grey.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: iconColor,
                  )
                : SizedBox(),
            icon != null
                ? const SizedBox(
                    width: 10,
                  )
                : SizedBox(),
            Text(
              text,
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
        minWidth: width,
        color: color,
        height: height,
        elevation: 0,
        onPressed: onPressed,
      ),
    ); // return InkWell(
  }
}
