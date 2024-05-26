import 'package:exam/Constructors/account.dart';
import 'package:flutter/material.dart';

class Cleaning {
  String title;
  DateTime expiration;
  String room;
  bool isDone;
  DateTime creationDate;
  DateTime completeDate;

  Cleaning({
    this.title = "",
    DateTime? expiration,
    this.room = "",
    this.isDone = false,
    DateTime? creationDate,
    DateTime? completeDate
  })  : expiration = expiration ?? DateTime.now(),
        creationDate = creationDate ?? DateTime.now(),
        completeDate = completeDate ?? DateTime.now();
}
