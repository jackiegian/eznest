import 'package:exam/Managers/data_manager.dart';
import 'package:exam/Screens/cleaning/cleaning_done.dart';
import 'package:exam/Screens/cleaning/cleaning_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';

class CleaningScreen extends StatefulWidget {

  final Account loginAccount;

  CleaningScreen({required this.loginAccount});

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
            CleaningList(loginAccount: widget.loginAccount,),
            CleaningDone(),
          ],
        ),
      ),
    );
  }
}
