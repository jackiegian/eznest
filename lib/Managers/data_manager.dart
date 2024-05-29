import 'package:exam/Constructors/account.dart';
import 'package:exam/Constructors/shopping_item.dart';
import 'package:exam/Data/sample_data.dart';
import 'package:flutter/material.dart';

import '../Constructors/cleaning_item.dart';

class DataManager extends ChangeNotifier {

  final List<Account> _allAccounts = SampleData.allAccount;
  final Map<Account, List<CleaningItem>> _accountCleaningMap = SampleData.accountCleaningMap;

  final List<ShoppingItem> _homeShopping = SampleData.homeShopping;

  List<Account> get allAccounts => _allAccounts;
  List<ShoppingItem> get homeShopping => _homeShopping;

  // settings

  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void changeDarkMode() {
    darkMode = !darkMode;
  }

  // login

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

  void resetLoginAccount() {
    loginAccount = null;
    notifyListeners();
  }

  // account

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

  // cleaning

  List<CleaningItem> getCleaningForAccountByUsername(String username) {
    Account? account = getAccountByUsername(username);

    List<CleaningItem> userCleaning = _accountCleaningMap[account] ?? [];
    return userCleaning;
  }

  void addCleaningForAccountByUsername(String username, CleaningItem cleaning) {
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

  void removeCleaningForAccountByUsername(String username, String id) {
    Account? account = getAccountByUsername(username);
    if (account != null && _accountCleaningMap.containsKey(account)) {
      _accountCleaningMap[account]!.removeWhere((cleaning) => cleaning.id == id);
      notifyListeners();
    }
  }

  void toggleCleaningItemCompleteById(String id) {
    var cleaningItem = _accountCleaningMap.values.expand((items) => items).firstWhere((item) => item.id == id);
    cleaningItem.isDone = !cleaningItem.isDone;
    cleaningItem.completeDate = DateTime.now();
    notifyListeners();
  }

  // shopping

  void removeShoppingItemById(String id) {
    homeShopping.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleShoppingItemCompleteById(String id) {
    var item = homeShopping.firstWhere((item) => item.id == id);
    item.isComplete = !item.isComplete;
    item.buyer = loginAccount!;
    notifyListeners();
  }

  void removeCompletedShoppingItems() {
    homeShopping.removeWhere((item) => item.isComplete);
    notifyListeners();
  }


}
