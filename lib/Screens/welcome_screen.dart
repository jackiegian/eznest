import 'package:exam/Managers/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> imgList = [
    "assets/landing/frame1.png",
    "assets/landing/frame2.png",
    "assets/landing/frame3.png"
  ];

  final List<String> imgTextList = [
    "Con eznest la vita tra coinquilini è più semplice!",
    "Crea e gestisci le pulizie all'interno della casa",
    "Crea la lista della spesa per tutta la casa"
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<DataManager>(
      builder: (context, manager, child) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          centerTitle: true,
          title: Text(
            "eznest",
            style: TextStyle(
              fontFamily: 'Chillax',
              fontSize: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
            onPressed: () {
              manager.changeDarkMode();
            },
            icon: manager.darkMode ? Icon(Icons.wb_sunny_rounded) : Icon(Icons.dark_mode_rounded)
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CarouselSlider(
                items: imgList.map((i) {
                  int index = imgList.indexOf(i);
                  return Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Flexible(child: Image.asset(i)),
                        Text(
                          imgTextList[index],
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: screenHeight * 0.5,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  enlargeCenterPage: true,
                  onPageChanged: (value, _) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              buildCarouselIndicator(),
              SizedBox(height: screenHeight * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
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
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      }
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            margin: EdgeInsets.all(5),
            height: i == _currentPage ? 7 : 5,
            width: i == _currentPage ? 7 : 5,
            decoration: BoxDecoration(
              color: i == _currentPage
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
