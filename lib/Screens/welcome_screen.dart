import 'package:exam/Managers/setting_manager.dart';
import 'package:exam/Screens/login_screen.dart';
import 'package:exam/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> ImgList = [
    "assets/landing/frame1.png",
    "assets/landing/frame2.png",
    "assets/landing/frame3.png",
    "assets/landing/frame4.png",
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<SettingsManager>(
      builder: (context, manager, child) {
        return Material(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                //Align(
                //    alignment: Alignment.centerRight,
                //    child: IconButton(
                //      icon: manager.darkMode
                //          ? Icon(Icons.wb_sunny_rounded) // Icona per la dark mode attiva
                //          : Icon(Icons.dark_mode_rounded),
                //      // Icona da visualizzare
                //        onPressed: () {
                //        manager.darkMode = !manager.darkMode;                      },
                //    )),
                SizedBox(height: screenHeight * 0.02),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: screenHeight * 0.05,
                      child: Image.asset('assets/logo/ez_logo.png')),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CarouselSlider(
                          items:
                              ImgList.map((i) => Center(child: Image.asset(i)))
                                  .toList(),
                          options: CarouselOptions(
                              height: screenHeight * 0.5,
                              initialPage: 0,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 2000),
                              enlargeCenterPage: true,
                              onPageChanged: (value, _) {
                                setState(() {
                                  _currentPage = value;
                                });
                              }),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        buildCarouselIndicator()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context)
                              .primaryColor, // Colore del bordo del pulsante
                          width: 2.0, // Spessore del bordo del pulsante
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signup', (route) => false);
                      },
                      child: Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text(
                            'Registrati',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text(
                            'Accedi',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < ImgList.length; i++)
          Container(
            margin: EdgeInsets.all(5),
            height: i == _currentPage ? 7 : 5,
            width: i == _currentPage ? 7 : 5,
            decoration: BoxDecoration(
              color: i == _currentPage
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
