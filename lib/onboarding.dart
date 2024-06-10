import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media_app/login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<Widget> _pages = [
    const Page1(),
    const Page2(),
    const Page3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 700,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, index) {
                return _pages[index % _pages.length];
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.black87,
                dotHeight: 8.0,
                dotWidth: 16.0,
                spacing: 10.0,
                expansionFactor: 4,
                strokeWidth: 2.0,
                ),

          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                  child: Text("Get started", style: TextStyle(fontSize: 20, color: Colors.white)),
                )),
          )
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(width: size.width,child: Image.asset("assets/images/onboarding.png", fit: BoxFit.fill,)),
          const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
          const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(width: size.width,child: Image.asset("assets/images/onboarding.png", fit: BoxFit.fill,)),
          const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(width: size.width,child: Image.asset("assets/images/onboarding.png", fit: BoxFit.fill,)),
          const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
