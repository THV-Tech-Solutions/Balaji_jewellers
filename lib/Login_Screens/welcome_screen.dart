//WelcomeScreen final

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewellery/Login_Screens/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              createPage(
                image: 'assets/images/bb1.png',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              createPage(
                image: 'assets/images/yy1.png',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              createPage(
                image: 'assets/images/first-e.png',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: GestureDetector(
              onTap: () {
                _nextPage();
              },
              child: Container(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() {
    setState(() {
      if (currentIndex < 2) {
        currentIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      indicators.add(_indicator(i == currentIndex));
    }

    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: isActive ? Constants.primaryColor : Colors.blueGrey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200), // Adjust the height as needed
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.fraunces(
              // You can replace 'Lato' with your desired Google Font
              textStyle: TextStyle(
                color: Constants.primaryColor,
                fontSize: 26, // Adjusted font size
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center, // Aligns text horizontally to center
            style: GoogleFonts.acme(
              //merienda
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
              fontStyle: FontStyle.normal,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class Constants {
  // Primary color
  static var primaryColor = Colors.orangeAccent; // A richer primary color
  static var blackColor = Colors.black54;

  // Onboarding texts
  static var titleOne = "Explore Our Shiny Jewelry";
  static var descriptionOne =
      "Check out beautiful gold, silver, diamond, rose gold, and gemstone pieces. We make them sparkle just for you.";
  static var titleTwo = "Expert Goldsmiths";
  static var descriptionTwo =
      "Feel the skill of our own top gold working. From classic gold designs to shiny diamonds, we make your wishes real.";
  static var titleThree = "Selectable Elegance";
  static var descriptionThree =
      "Enjoy beauty and art in every piece. Choose your special style from our handpicked gold, silver, diamond, rose gold, and gemstone choices.";
}
