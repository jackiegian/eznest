import 'package:exam/Managers/data_manager.dart';
import 'package:exam/home_page.dart';
import 'package:exam/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constructors/login_account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.loginAccount});

  final LoginAccount loginAccount;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedTabIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<DataManager>(builder: (context, manager, child) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Row(
            children: [
              Image.asset(
                "assets/logo/ez_logo.png",
                height: 25,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedTabIndex,
          children: _pages,
        ),
        bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.transparent,
          selectedIndex: _selectedTabIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.cleaning_services),
              icon: Icon(Icons.cleaning_services_outlined),
              label: "Pulizie",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Spesa",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.payments),
              icon: Icon(Icons.payments_outlined),
              label: "Pagamenti",
            ),
            NavigationDestination(
              icon: CircleAvatar(
                radius: 15,
                  backgroundImage: AssetImage(widget.loginAccount.imgProfile)
              ),
              label: "Profilo",
            ),
          ],
        ),
      );
    });
  }
}
