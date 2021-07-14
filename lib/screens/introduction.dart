import 'package:flutter/material.dart';
import 'package:sampling/constant/constants.dart';
import 'package:sampling/widgets/page_indicator.dart';
import 'package:sampling/widgets/pages/page_four.dart';
import 'package:sampling/widgets/pages/page_one.dart';
import 'package:sampling/widgets/pages/page_three.dart';
import 'package:sampling/widgets/pages/page_two.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentPage = 0;
  int _pages = 4;
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          decoration: kGradientboxDecoration,
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    // color: Colors.black,
                    width: size.width,
                    height: size.height * .83,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        PageOne(size: size),
                        PageTwo(size: size),
                        PageThree(size: size),
                        PageFour(size: size),
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                _buildIndicatorContainer(size),
                SizedBox(height: 1),
                if (_currentPage != 3)
                  Container(
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        OutlineButton(
                          color: Colors.red,
                          onPressed: _nextPage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
        ),
        bottomSheet: (_currentPage == 3)
            ? Container(
                color: Colors.grey.withOpacity(0.2),
                height: 70,
                width: size.width,
                child: Center(
                    child: GestureDetector(
                  onTap: () async {
                    await _checkLoggedIn();
                    // Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple[800]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Get Started',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800])),
                  ),
                )),
              )
            : null);
  }

  _checkLoggedIn() async {
    SharedPreferences lS = await SharedPreferences.getInstance();
    if (lS.getBool('logged_in') == null) {
      lS.setBool('logged_in', false);
    }
    if (lS.getBool('logged_in') == true) {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  Container _buildIndicatorContainer(Size size) {
    return Container(
      width: size.width,
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildIndicator(),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  _buildIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages; i++) {
      bool isActive = _currentPage == i;
      list.add(Indicator(isActive: isActive));
    }

    return list;
  }
}
