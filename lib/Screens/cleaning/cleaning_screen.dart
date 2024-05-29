import 'package:exam/Managers/data_manager.dart';
import 'package:exam/Screens/cleaning/cleaning_done.dart';
import 'package:exam/Screens/cleaning/cleaning_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import 'new_cleaning.dart';

class CleaningScreen extends StatefulWidget {

  @override
  State<CleaningScreen> createState() => _CleaningScreenState();
}

class _CleaningScreenState extends State<CleaningScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pulizie"),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Da svolgere"),
              Tab(text: "Svolte"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CleaningList(),
            CleaningDone(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'new_cleaning',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewCleaning()),
            );
          },
        ),
      ),
    );
  }
}
