import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/shopping_item.dart';
import '../../Managers/data_manager.dart';

class ShoppingTodo extends StatefulWidget {
  @override
  State<ShoppingTodo> createState() => _ShoppingTodoState();
}

class _ShoppingTodoState extends State<ShoppingTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataManager>(
        builder: (context, manager, child) {
          List<ShoppingItem> shoppings = manager.homeShopping.where((shopping) => !shopping.isComplete).toList();

          return Column(
            children: [
              Expanded(
                child: shoppings.isEmpty
                    ? Center(child: Text('Lista vuota'))
                    : ListView.separated(
                  itemBuilder: (context, index) {
                    ShoppingItem item = shoppings[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Conferma eliminazione"),
                                content: Text("Sei sicuro di voler eliminare questo elemento?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text("Annulla"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text("Elimina"),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        }
                        return false;
                      },
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            manager.removeShoppingItemById(item.id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Elemento eliminato")),
                          );
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            manager.toggleShoppingItemCompleteById(item.id);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Elemento comprato"),
                              action: SnackBarAction(
                                label: 'Annulla',
                                onPressed: () {
                                  setState(() {
                                    manager.toggleShoppingItemCompleteById(item.id);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                  Text("Quantità: "),
                                  Text(item.quantity.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
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
