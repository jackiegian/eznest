import 'package:exam/Screens/home_screen.dart';
import 'package:exam/Screens/login_screen.dart';
import 'package:exam/Screens/signup_screen.dart';
import 'package:exam/Screens/welcome_screen.dart';
import 'package:exam/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Managers/data_manager.dart';
import 'Constructors/login_account.dart';
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
                      // Controlla se ci sono argomenti passati e restituisci la pagina home con quegli argomenti
                      final args = settings.arguments as LoginAccount;
                      return MaterialPageRoute(
                        builder: (context) => HomeScreen(loginAccount: args),
                      );
                    case '/login':
                      return MaterialPageRoute(
                          builder: (context) => LoginScreen());
                    case '/signup':
                      return MaterialPageRoute(
                          builder: (context) => SignUpScreen());
                    default:
                      return null;
                  }
                });
          },
        )
    );
  }
}
