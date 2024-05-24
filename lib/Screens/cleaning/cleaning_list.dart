import 'package:exam/Managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import '../../Constructors/cleaning.dart';

class CleaningList extends StatefulWidget {
  final Account loginAccount;

  CleaningList({required this.loginAccount});

  @override
  State<CleaningList> createState() => _CleaningListState();
}

class _CleaningListState extends State<CleaningList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<DataManager>(
        builder: (context, manager, child) {
          List<Cleaning> cleanings = manager.getCleaningForAccountByUsername(widget.loginAccount.username);
          if (cleanings.isEmpty) {
            return Center(
              child: Image.asset(
                'assets/landing/frame7.png',
                width: screenWidth * 0.9, // larghezza uguale alla larghezza dello schermo
                height: screenHeight * 0.9, // altezza uguale all'altezza dello schermo
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                        ), // Aggiungi un bordo nero
                        borderRadius: BorderRadius.circular(10), // Bordo arrotondato
                      ),
                      child: Text(cleanings[index].title),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenWidth * 0.03,
                    );
                  },
                  itemCount: cleanings.length,

              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        },),
    );
  }
}
