import 'package:flutter/material.dart';
import '../Constructors/account.dart';

class SampleData {

  static Account account1 = Account(
    username: "Gianluca",
    password: "Gianluca",
    imgProfile: "assets/img_profile/profile_1.jpeg",
    isOnline: true,
  );
  static Account account2 = Account(
    username: "Flavio",
    password: "Flavio",
    imgProfile: "assets/img_profile/profile_2.jpeg",
    isOnline: false,
  );

  static List<Account> allAccount = [
    account1,
    account2
  ];

}