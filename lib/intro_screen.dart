import 'package:flutter/material.dart';
import 'package:fixit/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  final List<String> introSlideImages = ['assets/12.png', 'assets/15.png'];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
    checkIntroScreen();
  }

  void checkIntroScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introShown = prefs.getBool('introShown') ?? false;
    if (introShown) {
      navigateToLoginPage();
    }
  }

  void _markIntroScreenSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introShown', true);
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: introSlideImages.length + 1,
            itemBuilder: (context, index) {
              if (index < introSlideImages.length) {
                return buildIntroSlide(index);
              } else if (index == introSlideImages.length) {
                return buildLastSlide(context);
              } else {
                return Container();
              }
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                introSlideImages.length + 1,
                    (index) => buildDotIndicator(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIntroSlide(int index) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              introSlideImages[index],
              fit: BoxFit.contain,
            ),
          ),
          if (index == 1) buildSlideText(),
        ],
      ),
    );
  }

  Widget buildSlideText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Repair anything in a click!!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildLastSlide(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _markIntroScreenSeen(); // Mark intro screen as seen
        navigateToLoginPage();
      },
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 200, // Set the desired width
                height: 60, // Set the desired height
                child: ElevatedButton.icon(
                  onPressed: () {
                    _markIntroScreenSeen(); // Mark intro screen as seen
                    navigateToLoginPage();
                  },
                  icon: Icon(FontAwesomeIcons.play),
                  label: Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDotIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentPage ? Colors.black : Colors.grey,
      ),
    );
  }
}
