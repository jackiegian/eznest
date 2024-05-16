import 'package:exam/Constructors/account.dart';
import 'package:flutter/material.dart';

class LoginAccount {
  String username;
  String password;
  String imgProfile = "";
  bool isOnline = true;

  LoginAccount({
    required this.username,
    required this.password,
    this.imgProfile = "",
    this.isOnline = true
  });

  LoginAccount fromAccount (Account account) {
    return LoginAccount(
        username: account.username,
        password: account.password,
        imgProfile: account.imgProfile,
        isOnline: account.isOnline
    );
  }
}