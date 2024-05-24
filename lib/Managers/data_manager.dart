import 'package:exam/Constructors/account.dart';
import 'package:exam/Data/sample_data.dart';
import 'package:flutter/material.dart';

import '../Constructors/cleaning.dart';

class DataManager extends ChangeNotifier {

  final List<Account> _allAccounts = SampleData.allAccount;
  final Map<Account, List<Cleaning>> _accountCleaningMap = SampleData.accountCleaningMap;

  List<Account> get allAccounts => List.unmodifiable(_allAccounts);

  void addAccount(Account account) {
    _allAccounts.add(account);
    _accountCleaningMap[account] = [];
    notifyListeners();
  }

  Account? getAccountByUsername(String username) {
    return _allAccounts.firstWhere((account) => account.username == username);
  }

  List<Cleaning> getCleaningForAccountByUsername(String username) {
    Account? account = getAccountByUsername(username);
    if (account == null) {
      return [];
    }
    return _accountCleaningMap[account] ?? [];
  }

  void addCleaningForAccountByUsername(String username, Cleaning cleaning) {
    Account? account = getAccountByUsername(username);
    if (account != null) {
      if (_accountCleaningMap.containsKey(account)) {
        _accountCleaningMap[account]!.add(cleaning);
      } else {
        _accountCleaningMap[account] = [cleaning];
      }
      notifyListeners();
    }
  }
}