import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import '../../Managers/data_manager.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  bool passToggle = true;

  void registraAccount(BuildContext context) {
    String name = nameController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String repeatPassword = repeatPasswordController.text;

    // Verifica se le password coincidono
    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Le password non coincidono.')),
      );
      return;
    }

    // Ottieni gli account utilizzando il Consumer
    final accountList = Provider.of<DataManager>(context, listen: false);
    List<Account> accounts = accountList.allAccounts;

    // Controlla se l'username esiste già
    for (Account account in accounts) {
      if (account.username == username) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username già in uso.')),
        );
        return;
      }
    }

    // Crea un LoginAccount e naviga alla home
    Account signupAccount = Account(
      username: username,
      password: password,
      imgProfile: "",
      isOnline: true,
      name: name
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/signup_image',
          (route) => false,
      arguments: signupAccount,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 48,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo/ez_logo.png",
              height: screenHeight * 0.03,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Text(
                  'Benvenuto!',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Registrati compilando i campi sottostanti',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.03),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (valueName) {
                      if (valueName == null || valueName.isEmpty) {
                        return 'Inserisci un nome.';
                      }
                      return null;
                    },
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.abc_rounded),
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Nome',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
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
                SizedBox(height: screenHeight * 0.03),
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
                    textInputAction: TextInputAction.next,
                    controller: passwordController,
                    obscureText: passToggle ? true : false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
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
                    controller: repeatPasswordController,
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
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(
                          passToggle
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FilledButton(
                    onPressed: () {
                      registraAccount(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Text('Registrati'),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sei già registrato?",
                      style: TextStyle(fontSize: 13),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Accedi",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}