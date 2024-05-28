import 'package:exam/Managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  child: SizedBox(
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.3,
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
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
                        SizedBox(height: screenHeight * 0.02,),
                        Text(manager.loginAccount!.name,
                        style: TextStyle(
                          fontSize: 24
                        ),)
                      ])),
                ),
              )
            ]));
      },
    );
  }
}
