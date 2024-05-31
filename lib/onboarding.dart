import 'package:flutter/material.dart';
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
            height: 610,
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _pages.length,
                  (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.black,
                        ),
                      ))),
            ),
          ),
          ElevatedButton(onPressed: () {
            if (_activePage == _pages.length - 1) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            } else {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            }
          }, child: const Text("Get started")),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("assets/images/onboarding.png"),
          const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("assets/images/onboarding.png"),
           const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("assets/images/onboarding.png"),
           const Text("Let's connect with each other",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
