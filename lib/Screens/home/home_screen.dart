import 'package:exam/Constructors/shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam/Managers/data_manager.dart';

import '../../Constructors/account.dart';
import '../../Constructors/cleaning_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Text(
          "eznest",
          style: TextStyle(
            fontFamily: 'Chillax',
            fontSize: 45,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Consumer<DataManager>(builder: (context, manager, child) {
        List<Account> orderedAccounts =
            manager.getAccountsWithPriorityByUsername(
                manager.loginAccount!.username, manager.allAccounts);
        Iterable<CleaningItem> cleanings = manager
            .getCleaningForAccountByUsername(manager.loginAccount!.username)
            .where((cleaning) => !cleaning.isDone);
        Iterable<ShoppingItem> shoppings =
            manager.homeShopping.where((shopping) => !shopping.isComplete);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "La mia casa",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
                height: screenHeight * 0.15,
                margin: EdgeInsets.only(top: screenHeight * 0.01),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight * 0.18,
                      width: screenWidth * 0.18,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  orderedAccounts[index].imgProfile,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            index == 0 ? "Tu" : orderedAccounts[index].name,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: screenWidth * 0.03,
                    );
                  },
                  itemCount: manager.allAccounts.length,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Le mie attività",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Pulizia"),
                            Text(cleanings.isEmpty
                                ? "Nessuna pulizia"
                                : cleanings.length.toString())
                          ],
                        ),
                        IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.primary,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Spesa"),
                            Text(cleanings.isEmpty
                                ? "Niente da comprare"
                                : shoppings.length.toString())
                          ],
                        ),
                        IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.primary,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
