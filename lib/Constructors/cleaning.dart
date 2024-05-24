import 'package:exam/Constructors/account.dart';
import 'package:flutter/material.dart';

class Cleaning {
  String title;
  DateTime expiration;
  String room;
  bool isDone;

  Cleaning({
    this.title = "",
    DateTime? expiration,
    this.room = "",
    this.isDone = false,
  }) : expiration = expiration ?? DateTime.now();

}
