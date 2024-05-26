import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam/Managers/data_manager.dart';

import '../../Constructors/account.dart';

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
        title: Row(
          children: [
            Image.asset(
              "assets/logo/ez_logo.png",
              height: 25,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
      body: Consumer<DataManager>(builder: (context, manager, child) {
        List<Account> orderedAccounts = manager.getAccountsWithPriorityByUsername(manager.loginAccount!.username, manager.allAccounts);
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
                                    color: (orderedAccounts[index].isOnline
                                        ? Colors.green
                                        : Colors.red),
                                    width: 3,
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
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Image.asset(
                      "assets/landing/frame6.png",
                      height: screenHeight * 0.4,
                    ),
                  )
                ],
              ),
            );
      }),
    );
  }
}
