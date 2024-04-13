import 'package:flutter/material.dart';

class Button {
  int id;
  String icon;
  String title;
  String description;
  Function onClickListener;
  Color color;

  Button(
      {required this.id,
      required this.icon,
      required this.title,
      required this.description,
      required this.onClickListener,
      required this.color});
}
