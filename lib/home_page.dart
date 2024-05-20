import 'package:exam/Managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<DataManager>(builder: (context, manager, child) {
      return ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "La mia casa",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  height: screenHeight * 0.1,
                  margin: EdgeInsets.only(top: screenHeight * 0.01),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                              width: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: (manager.allAccount[index].isOnline ? Colors.green : Colors.red),
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      manager.allAccount[index].imgProfile),
                                ),
                              ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: screenWidth * 0.03,
                        );
                      },
                      itemCount: manager.allAccount.length),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                        color: Theme.of(context)
                            .primaryColor, // Colore del bordo del pulsante
                        width: 2.0
                    )
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Image.asset(
                        "assets/landing/frame6.png",
                    height: screenHeight * 0.4,)
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
