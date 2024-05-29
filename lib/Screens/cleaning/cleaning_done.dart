import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constructors/cleaning_item.dart';
import '../../Managers/data_manager.dart';

class CleaningDone extends StatefulWidget {
  @override
  State<CleaningDone> createState() => _CleaningDoneState();
}

class _CleaningDoneState extends State<CleaningDone> {
  List<String> filters = ['Tutte', 'Scadute'];

  String selectedFilter = 'Tutte';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<DataManager>(
        builder: (context, manager, child) {
          List<CleaningItem> cleanings = manager
              .getCleaningForAccountByUsername(manager.loginAccount!.username);

          if (selectedFilter == 'Scadute') {
            cleanings = cleanings.where((cleaning) =>
            cleaning.isDone &&
                cleaning.expiration.isBefore(
                    cleaning.completeDate.subtract(Duration(days: 1)))).toList();
          } else {
            cleanings = cleanings.where((cleaning) => cleaning.isDone).toList();
          }

          cleanings.sort((a, b) => b.completeDate.compareTo(a.completeDate));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                height: 50,
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
                          if (cleanings[index].isDone) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_filled_rounded,
                                            color: cleanings[index]
                                                    .expiration
                                                    .isBefore(cleanings[index]
                                                        .completeDate.subtract(Duration(days: 1)))
                                                ? Colors.red
                                                : Colors.green,
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
                                                  title: Text(
                                                      cleanings[index].title),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Stanza: ${cleanings[index].room}"),
                                                      Text(
                                                          "Scadenza: ${DateFormat('dd/MM/yyyy').format(cleanings[index].expiration)}"),
                                                      Text(
                                                          "Completata il: ${DateFormat('dd/MM/yyyy').format(cleanings[index].completeDate)}"),
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
                            );
                          }
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
