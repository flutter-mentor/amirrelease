import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void navigateTo(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => true);
}

String intToString(int index) {
  String synonmInText = '';
  switch (index) {
    case 0:
      synonmInText = '${index + 1}st intake';
      break;
    case 1:
      synonmInText = '${index + 1}nd intake';
      break;
    case 2:
      synonmInText = '${index + 1}rd intake';
      break;
    case 3:
      synonmInText = '${index + 1}th intake';
      break;
    default:
      synonmInText = '${index + 1}th intake';
  }
  return synonmInText;
}

String firstLetter(String name) {
  String firstLetter = name.characters.first.toUpperCase();
  return firstLetter;
}
