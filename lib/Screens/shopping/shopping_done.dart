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
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DataManager>(
      builder: (context, manager, child) {
        // Filtra la lista degli articoli in base al filtro selezionato
        List<ShoppingItem> shoppings = manager.homeShopping.where((shopping) {
          return shopping.isComplete;
        }).toList();

        return Column(
          children: [
            // Visualizza i filtri come ChoiceChip

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
                                  color: Theme.of(context).primaryColor,
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
                            ));
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
    ));
  }
}
