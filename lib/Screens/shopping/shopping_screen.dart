import 'package:exam/Screens/shopping/shopping_done.dart';
import 'package:exam/Screens/shopping/shopping_todo.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Spesa"),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Da comprare"),
              Tab(text: "Comprato"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ShoppingTodo(),
            ShoppingDone()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'new_shopping_item',
          child: Icon(Icons.add),
          onPressed: () {

          },
        ),
      ),
    );
  }
}