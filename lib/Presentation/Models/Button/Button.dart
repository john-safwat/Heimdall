import 'package:flutter/material.dart';

class Button {
  int id;
  IconData icon;
  String title;
  Function onClickListener;

  Button(
      {required this.id,
      required this.icon,
      required this.title,
      required this.onClickListener,
      });
}
