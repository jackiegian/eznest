import 'package:exam/Constructors/account.dart';
import 'package:exam/Screens/cleaning/new_cleaning.dart';
import 'package:exam/Screens/main_screen.dart';
import 'package:exam/Screens/login_signup/login_screen.dart';
import 'package:exam/Screens/login_signup/signup_image.dart';
import 'package:exam/Screens/login_signup/signup_screen.dart';
import 'package:exam/Screens/welcome_screen.dart';
import 'package:exam/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Managers/data_manager.dart';
import 'Managers/setting_manager.dart';


void main() {
  runApp(EznestApp());
}

class EznestApp extends StatefulWidget {
  @override
  State<EznestApp> createState() => _MyAppState();
}

class _MyAppState extends State<EznestApp> {
  final DataManager _dataManager = DataManager();
  final SettingsManager _settingsManager = SettingsManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _dataManager,
          ),
          ChangeNotifierProvider(
            create: (context) => _settingsManager,
          ),
        ],
        child: Consumer<SettingsManager>(
          builder: (context, manager, child) {
            ThemeData maintheme;
            if(manager.darkMode) {
              maintheme = EznestTheme.dark();
            } else {
              maintheme = EznestTheme.light();
            }
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: maintheme,
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case '/':
                      return MaterialPageRoute(
                          builder: (context) => WelcomeScreen());
                    case '/home':
                      return MaterialPageRoute(
                        builder: (context) => MainScreen(),);
                    case '/login':
                      return MaterialPageRoute(
                          builder: (context) => LoginScreen());
                    case '/signup':
                      return MaterialPageRoute(
                          builder: (context) => SignUpScreen());
                    case '/signup_image':
                      return MaterialPageRoute(
                          builder: (context) => SignUpImageScreen());
                    default:
                      return null;
                  }
                });
          },
        )
    );
  }
}
