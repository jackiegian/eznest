import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constructors/account.dart';
import '../Managers/data_manager.dart';
import '../Constructors/login_account.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void effettuaLogin(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    // Otteniamo gli account utilizzando il Consumer
    final accountList = Provider.of<DataManager>(context, listen: false);
    List<Account> accounts = accountList.allAccount;

    // Controllo sugli account
    for (Account account in accounts) {
      if (account.username == username && account.password == password) {
        // Trovata corrispondenza: crea un LoginAccount e passalo alla pagina successiva
        LoginAccount loginAccount = LoginAccount(
          username: account.username,
          password: account.password,
          imgProfile: account.imgProfile,
          isOnline: account.isOnline,
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
          arguments: loginAccount, // Passa il costruttore come parametro
        );
        break; // Esci dal ciclo se trovi una corrispondenza
      }
    }
  }

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 64,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/logo/ez_logo.png",
                height: screenHeight * 0.02,
                fit: BoxFit.cover,
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              Text(
                'Benvenuto!',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                'Registrati compilando i campi sottostanti',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (valueUsername) {
                    if (valueUsername == null || valueUsername.isEmpty) {
                      return 'Inserisci un username.';
                    }
                    return null;
                  },
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Username',
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (valuePassword) {
                    if (valuePassword == null || valuePassword.isEmpty) {
                      return 'Inserisci una password.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Password',
                    suffixIcon: InkWell(
                        onTap: () {
                          if (passToggle == true) {
                            passToggle = false;
                          } else {
                            passToggle = true;
                          }
                          setState(() {});
                        },
                        child: passToggle
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(CupertinoIcons.eye_fill)),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (valuePassword) {
                    if (valuePassword == null || valuePassword.isEmpty) {
                      return 'Inserisci una password.';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  controller: passwordController,
                  obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Ripeti Password',
                    suffixIcon: InkWell(
                        onTap: () {
                          if (passToggle == true) {
                            passToggle = false;
                          } else {
                            passToggle = true;
                          }
                          setState(() {});
                        },
                        child: passToggle
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(CupertinoIcons.eye_fill)),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FilledButton(
                    onPressed: () {
                      effettuaLogin(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.05),
                      child: Text('Accedi'),
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sei già registrato?",
                    style: TextStyle(
                      fontSize: 13,
                    ),),
                  TextButton(onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                            (route) => false);
                  },
                      child: Text(
                        "Accedi",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
