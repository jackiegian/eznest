import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/shopping_item.dart';
import '../../Constructors/account.dart';
import '../../Managers/data_manager.dart';

class ShoppingDone extends StatefulWidget {
  @override
  State<ShoppingDone> createState() => _ShoppingDoneState();
}

class _ShoppingDoneState extends State<ShoppingDone> {
  String selectedBuyer = "Tutti";

  List<Account> getAccountsWithPriorityByUsername(String username, List<Account> accounts) {
    Account? priorityAccount;
    for (var account in accounts) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataManager>(
        builder: (context, manager, child) {
          // Ottieni la lista degli account
          List<Account> allAccounts = manager.allAccounts;
          List<Account> accountsWithPriority = getAccountsWithPriorityByUsername(manager.loginAccount!.username, allAccounts);

          // Aggiungi un'opzione "Tutti" all'inizio della lista degli account
          List<String> buyers = ["Tutti"];
          buyers.addAll(accountsWithPriority.map((account) => account.name).toList());

          // Filtra la lista degli articoli in base all'acquirente selezionato
          List<ShoppingItem> shoppings = manager.homeShopping.where((shopping) {
            return shopping.isComplete &&
                (selectedBuyer == null || selectedBuyer == "Tutti" || shopping.buyer.name == selectedBuyer);
          }).toList();

          return Column(
            children: [
              // Visualizza gli account come ChoiceChip
              Container(
                margin: EdgeInsets.all(8),
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: buyers.length,
                  itemBuilder: (BuildContext context, int index) {
                    String buyer = buyers[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(buyer),
                        selected: selectedBuyer == buyer || (selectedBuyer == null && buyer == "Tutti"),
                        onSelected: (selected) {
                          setState(() {
                            selectedBuyer = (selected ? buyer : null)!;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              // Visualizza gli articoli completati
              Expanded(
                child: shoppings.isEmpty
                    ? Center(child: Text('Lista vuota'))
                    : ListView.separated(
                  itemBuilder: (context, index) {
                    ShoppingItem item = shoppings[index];
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(item.buyer.name),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 0,
                    );
                  },
                  itemCount: shoppings.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
