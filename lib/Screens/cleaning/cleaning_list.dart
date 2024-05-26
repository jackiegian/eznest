import 'package:exam/Managers/data_manager.dart';
import 'package:exam/Screens/cleaning/new_cleaning.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import '../../Constructors/cleaning.dart';

class CleaningList extends StatefulWidget {
  @override
  State<CleaningList> createState() => _CleaningListState();
}

class _CleaningListState extends State<CleaningList> {
  List<String> filters = ['Più recenti', 'In scadenza'];

  String selectedFilter = 'Più recenti';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<DataManager>(
        builder: (context, manager, child) {
          List<Cleaning> cleanings = manager
              .getCleaningForAccountByUsername(manager.loginAccount!.username);

          if (selectedFilter == 'In scadenza') {
            cleanings.sort((a, b) => a.expiration.compareTo(b.expiration));
          } else {
            // Ordina per la data di creazione più recente
            cleanings.sort((a, b) => b.creationDate.compareTo(a.creationDate));
          }

          cleanings = cleanings.where((cleaning) => !cleaning.isDone).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                height: screenHeight * 0.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) {
                    String filter = filters[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: cleanings.isEmpty
                    ? Center(
                  child: Text('Nessuna pulizia disponibile'),
                )
                    : ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
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
                                content: Text(
                                    "Sei sicuro di voler eliminare questa pulizia?"),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text("Annulla"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
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
                            manager.getCleaningForAccountByUsername(manager.loginAccount!.username).removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Pulizia eliminata")),
                          );
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            cleanings[index].isDone = true;
                            cleanings[index].completeDate = DateTime.now();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pulizia completata"),
                              action: SnackBarAction(
                                label: 'Annulla',
                                onPressed: () {
                                  setState(() {
                                    cleanings[index].isDone = false;
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
                                color: Theme.of(context).primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_filled_rounded,
                                      color: cleanings[index].expiration.isBefore(DateTime.now().subtract(Duration(days: 1)))
                                          ? Colors.red : Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      cleanings[index].title,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(cleanings[index].title),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Stanza: ${cleanings[index].room}"),
                                                Text("Scadenza: ${DateFormat('dd/MM/yyyy').format(cleanings[index].expiration)}"),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Dettagli"),
                                  ),
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
                  itemCount: cleanings.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
