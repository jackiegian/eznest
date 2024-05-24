import 'package:exam/Constructors/account.dart';
import 'package:exam/Managers/data_manager.dart';
import 'package:exam/Screens/cleaning/cleaning_screen.dart';
import 'package:exam/Screens/home/home_screen.dart';
import 'package:exam/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  final Account loginAccount;

  const MainScreen({required this.loginAccount});



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {



    final List<Widget> _pages = <Widget>[
      HomeScreen(),
      CleaningScreen(loginAccount: widget.loginAccount)
    ];

    return Scaffold(
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
                backgroundImage: AssetImage(widget.loginAccount.imgProfile)),
            label: "Profilo",
          ),
        ],
      ),
    );
    ;
  }
}
