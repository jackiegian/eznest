import 'package:exam/Constructors/account.dart';
import 'package:exam/Data/sample_data.dart';
import 'package:flutter/material.dart';

class DataManager extends ChangeNotifier {

  final List<Account> _allAccount = SampleData.allAccount;

  List<Account> get allAccount => List.unmodifiable(_allAccount);

  void addAccount(Account account) {
    _allAccount.add(account);
    notifyListeners();
  }
}