import 'package:exam/Constructors/cleaning_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import '../../Managers/data_manager.dart';

class NewCleaning extends StatefulWidget {
  @override
  State<NewCleaning> createState() => _NewCleaningState();
}

class _NewCleaningState extends State<NewCleaning> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedRoom = '';
  String selectedUsername = '';

  List<String> rooms = [
    'Cucina',
    'Soggiorno',
    'Camera da letto',
    'Bagno',
    'Altro'
  ];

  void CreateCleaning(BuildContext context) {
    String title = titleController.text;
    DateTime? expiration = DateFormat('dd-MM-yyyy').parse(dateController.text);
    String room = selectedRoom;
    String username = selectedUsername;

    final dataManager = Provider.of<DataManager>(context, listen: false);

    if (title.isNotEmpty && room.isNotEmpty && username.isNotEmpty) {
      CleaningItem newCleaning = CleaningItem(
        title: title,
        expiration: expiration,
        room: room,
        isDone: false,
      );

      dataManager.addCleaningForAccountByUsername(username, newCleaning);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per favore, compila tutti i campi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Nuova pulizia"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
                child: Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                      child: Column(
              children: [
                BuildCleaningTitle(),
                SizedBox(height: screenHeight * 0.03),
                BuildCleaningExpiaration(context),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Text("Seleziona una camera"),
                  ],
                ),
                SizedBox(
                      height: screenHeight * 0.1,
                      child: BuildCleaningRoom(context)),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Text("Seleziona chi deve pulire"),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Consumer<DataManager>(builder: (context, manager, child) {
                  List<Account> orderedAccounts =
                        manager.getAccountsWithPriorityByUsername(
                            manager.loginAccount!.username, manager.allAccounts);
                  return Container(
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
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedUsername =
                                          orderedAccounts[index].username;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: selectedUsername ==
                                                orderedAccounts[index].username
                                            ? Theme.of(context).colorScheme.primary
                                            : Colors.transparent,
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
                        itemCount: orderedAccounts.length,
                      ),
                  );
                }),
                SizedBox(height: screenHeight * 0.02),
                FilledButton(
                  onPressed: () {
                      CreateCleaning(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.1,
                      ),
                      child: Text('Crea'),
                  ),
                ),
              ],
            ),
                    )))));
  }

  Widget BuildCleaningTitle() {
    return TextFormField(
      controller: titleController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (valueName) {
        if (valueName == null || valueName.isEmpty) {
          return 'Inserisci un titolo.';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.abc_rounded),
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: 'Scegli un titolo',
      ),
    );
  }

  Widget BuildCleaningExpiaration(BuildContext context) {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateController.text = formattedDate;
          });
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_month_rounded),
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: 'Seleziona una scadenza',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (valueDate) {
        if (valueDate == null || valueDate.isEmpty) {
          return 'Inserisci una data.';
        }
        final DateTime? selectedDate =
            DateFormat('dd-MM-yyyy').parse(valueDate, true).toUtc();
        if (selectedDate!.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
          return 'La data non è valida.';
        }
        return null;
      },
    );
  }

  Widget BuildCleaningRoom(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: rooms.length,
      itemBuilder: (BuildContext context, int index) {
        String room = rooms[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(room),
            selected: selectedRoom == room,
            onSelected: (selected) {
              setState(() {
                selectedRoom = selected ? room : '';
              });
            },
          ),
        );
      },
    );
  }
}
