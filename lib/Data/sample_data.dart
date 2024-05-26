import 'package:flutter/material.dart';
import '../Constructors/account.dart';
import '../Constructors/cleaning.dart';

class SampleData {
  static Account account1 = Account(
      username: "Gianluca",
      password: "Gianluca",
      imgProfile: "assets/img_profile/profile_1.jpeg",
      isOnline: true,
      name: "Gianluca");
  static Account account2 = Account(
      username: "Flavio",
      password: "Flavio",
      imgProfile: "assets/img_profile/profile_2.jpeg",
      isOnline: false,
      name: "Flavio");

  static List<Account> allAccount = [account1, account2];

  static Cleaning cleaning1 = Cleaning(
      title: 'Pulizia cucina',
      expiration: DateTime.now().subtract(Duration(days: 7)),
      room: "Cucina",
      isDone: false,
      creationDate: DateTime.now());

  static Cleaning cleaning2 = Cleaning(
      title: 'Pulire bagno',
      expiration: DateTime.now(),
      room: "Bagno",
      isDone: false,
      creationDate: DateTime.now());

  static Cleaning cleaning3 = Cleaning(
      title: 'Pulire soggiorno',
      expiration: DateTime.now(),
      room: "Soggiorno",
      isDone: false,
      creationDate: DateTime.now());

  static Map<Account, List<Cleaning>> accountCleaningMap = {
    account1: [cleaning1],
    account2: [cleaning1, cleaning2, cleaning3],
  };
}
