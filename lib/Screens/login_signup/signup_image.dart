import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constructors/account.dart';
import '../../Managers/data_manager.dart';

class SignUpImageScreen extends StatefulWidget {
  const SignUpImageScreen({super.key, required this.signupAccount});

  final Account signupAccount;

  @override
  State<SignUpImageScreen> createState() => _SignUpImageScreenState();
}

class _SignUpImageScreenState extends State<SignUpImageScreen> {

  final List<String> ImgProfiles = [
    "assets/img_profile/profile_1.jpeg",
    "assets/img_profile/profile_2.jpeg",
    "assets/img_profile/profile_3.jpeg",
    "assets/img_profile/profile_4.jpeg",
    "assets/img_profile/profile_5.jpeg",
    "assets/img_profile/profile_6.jpeg",
  ];

  String? selectedImage;



  void immagineProfilo(BuildContext context) {

    final accountList = Provider.of<DataManager>(context, listen: false);

    if (selectedImage != null) {
      Account loginAccount = Account(
        name: widget.signupAccount.name,
        username: widget.signupAccount.username,
        password: widget.signupAccount.password,
        imgProfile: selectedImage!,
        isOnline: widget.signupAccount.isOnline,
      );
      accountList.addAccount(loginAccount);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (route) => false,
        arguments: loginAccount,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Per favore, seleziona un'immagine")),
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
          )),
      body:
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ciao ',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                      widget.signupAccount.name,
                      style: TextStyle(fontSize: 30)
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                "Seleziona un'immagine per il tuo profilo",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.all(10),
                  itemCount: ImgProfiles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = ImgProfiles[index];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedImage == ImgProfiles[index] ? Theme.of(context).primaryColorDark : Colors.transparent,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImgProfiles[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FilledButton(
                  onPressed: () {
                    immagineProfilo(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Text('Inizia'),
                  ),
                ),
              ),
            ],
          ),

    );
  }
}