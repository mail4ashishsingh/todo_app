import 'package:flutter/material.dart';
import 'widgets/index.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int _totalPage = 8;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _totalPage,
              itemBuilder: (context, int index) {
                // print(sliderArrayList[index]);
                switch (index) {
                  case 0:
                    return Page00Screen();
                    break;
                  case 1:
                    return Page01Screen();
                    break;
                  case 2:
                    return Page02Screen();
                    break;
                  case 3:
                    return Page03Screen();
                    break;
                  case 4:
                    return Page04Screen();
                    break;
                  case 5:
                    return Page05Screen();
                    break;
                  case 6:
                    return Page06Screen();
                    break;
                  case 7:
                    return Page07Screen();
                    break;
                }
                return Offstage();
              },
            ),
            (_currentPage == 0 || _currentPage == 6 || _currentPage == 7)
                ? Offstage()
                : Positioned(
                    top: MediaQuery.of(context).size.height * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < _totalPage; i++)
                          if (i == _currentPage)
                            slideDots(true)
                          else
                            slideDots(false)
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget slideDots(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
