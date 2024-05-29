import 'package:exam/Constructors/shopping_item.dart';
import 'package:flutter/material.dart';
import '../Constructors/account.dart';
import '../Constructors/cleaning_item.dart';

class SampleData {

  // account

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

  // cleaning

  static CleaningItem cleaning1 = CleaningItem(
      title: 'Pulizia cucina',
      expiration: DateTime.now().subtract(Duration(days: 7)),
      room: "Cucina",
      isDone: false,
      creationDate: DateTime.now());

  static CleaningItem cleaning2 = CleaningItem(
      title: 'Pulire bagno',
      expiration: DateTime.now(),
      room: "Bagno",
      isDone: false,
      creationDate: DateTime.now());

  static CleaningItem cleaning3 = CleaningItem(
      title: 'Pulire soggiorno',
      expiration: DateTime.now(),
      room: "Soggiorno",
      isDone: false,
      creationDate: DateTime.now());

  static Map<Account, List<CleaningItem>> accountCleaningMap = {
    account1: [cleaning1],
    account2: [cleaning1, cleaning2, cleaning3],
  };

  // shopping

  static ShoppingItem shopping1 = ShoppingItem(
    title: "Pane",
    buyer: Account(),
    quantity: 1,
    isComplete: false
  );

  static ShoppingItem shopping2 = ShoppingItem(
      title: "Detersivo piatti",
      buyer: Account(),
      quantity: 1,
      isComplete: false
  );

  static ShoppingItem shopping3 = ShoppingItem(
      title: "Verdura",
      buyer: Account(),
      quantity: 2,
      isComplete: false
  );

  static ShoppingItem shopping4 = ShoppingItem(
      title: "Carne",
      buyer: Account(),
      quantity: 3,
      isComplete: false
  );

  static List<ShoppingItem> homeShopping = [shopping1, shopping2, shopping3, shopping4];

}
