import 'package:exam/Constructors/account.dart';
import 'package:exam/Data/sample_data.dart';
import 'package:flutter/material.dart';

import '../Constructors/cleaning.dart';

class DataManager extends ChangeNotifier {

  final List<Account> _allAccounts = SampleData.allAccount;
  final Map<Account, List<Cleaning>> _accountCleaningMap = SampleData.accountCleaningMap;

  List<Account> get allAccounts => _allAccounts;

  Account? loginAccount;

  void setLoginAccountFromCredentials(String username, String password) {
    Account? loginAccountFromAccounts = _allAccounts.firstWhere((account) => account.username == username && account.password == password);
    loginAccount = loginAccountFromAccounts;
    notifyListeners();
  }

  void setLoginAccount(Account account) {
    loginAccount = account;
    notifyListeners();
  }

  void addAccount(Account account) {
    _allAccounts.add(account);
    _accountCleaningMap[account] = [];
    notifyListeners();
  }

  List<Account> getAccountsWithPriorityByUsername(String username, List<Account> accounts) {

    Account? priorityAccount;
    for (var account in allAccounts) {
      if (account.username == username) {
        priorityAccount = account;
        break;
      }
    }

    if (priorityAccount != null) {
      accounts.remove(priorityAccount);
      accounts.insert(0, priorityAccount);
    }

    return accounts;
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
        _accountCleaningMap[account]!.insert(0, cleaning);
      } else {
        _accountCleaningMap[account] = [cleaning];
      }
      notifyListeners();
    }
  }

}