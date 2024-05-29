import 'package:exam/Managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Conferma Logout"),
          content: Text("Sei sicuro di voler uscire dall'app?"),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                child: Text("Annulla"),
                onPressed: () {
                  Navigator.of(context).pop(); // Chiude il dialogo
                },
              ),
              TextButton(
                child: Text("Esci"),
                onPressed: () {
                  Provider.of<DataManager>(context, listen: false)
                      .resetLoginAccount();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ])
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Profilo"),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
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
                              manager.loginAccount!.imgProfile,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(manager.loginAccount!.name,
                        style: TextStyle(fontSize: 24)),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.dark_mode_rounded),
                                SizedBox(width: 24),
                                Text("Modalità scura"),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8, // Adjust the scale as needed
                            child: Consumer<DataManager>(
                              builder: (context, manager, child) {
                                return Switch(
                                    value: manager.darkMode,
                                    onChanged: (value) {
                                      manager.darkMode = value;
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.mode_rounded),
                                  SizedBox(width: 24),
                                  Text("Cambia nome"),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.image_rounded),
                                  SizedBox(width: 24),
                                  Text("Cambia immagine profilo"),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Center(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        label: Text("Esci"),
                      ),
                    )
                  ],
                ),
              ),
            ]));
      },
    );
  }
}
