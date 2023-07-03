import 'dart:io';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  DateTime? backPressTime;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pageModelList = [
      PageModel(
        widget: Container(
          width: size.width,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/onboarding/onboarding1.png",
                height: size.width * 0.6,
                width: size.width * 0.6,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Center(
                  child: Text(
                    getTranslation(context, 'onboarding.title1'),
                    style: bold20LightBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              heightSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  getTranslation(context, 'onboarding.text1'),
                  style: semibold15Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      PageModel(
        widget: Container(
          width: size.width,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/onboarding/onboarding2.png",
                height: size.width * 0.6,
                width: size.width * 0.6,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  getTranslation(context, 'onboarding.title2'),
                  style: bold20LightBlack,
                  textAlign: TextAlign.center,
                ),
              ),
              heightSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  getTranslation(context, 'onboarding.text2'),
                  style: semibold15Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      PageModel(
        widget: Container(
          width: size.width,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/onboarding/onboarding3.png",
                height: size.width * 0.6,
                width: size.width * 0.6,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  getTranslation(context, 'onboarding.title3'),
                  style: bold20LightBlack,
                  textAlign: TextAlign.center,
                ),
              ),
              heightSpace,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: Text(
                  getTranslation(context, 'onboarding.text3'),
                  style: semibold15Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      )
    ];

    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Onboarding(
                pages: pageModelList,
                startPageIndex: currentIndex,
                onPageChange: (index) {
                  setState(
                    () {
                      currentIndex = index;
                    },
                  );
                },
                footerBuilder:
                    (context, netDragDistance, pagesLength, setIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(fixPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentIndex + 1 == pagesLength
                            ? TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: fixPadding),
                                  ),
                                ),
                                onPressed: null,
                                child: Text(
                                  "",
                                  style: bold14Grey,
                                ),
                              )
                            : skipButton(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pagesLength,
                            (index) => _bildDot(index),
                          ),
                        ),
                        currentIndex + 1 == pagesLength
                            ? loginButton()
                            : nextButton(),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _bildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
      height: currentIndex == index ? 10 : 6,
      width: currentIndex == index ? 10 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            currentIndex == index ? lightBlackColor : const Color(0xFFBFBFBF),
      ),
    );
  }

  loginButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: fixPadding),
        ),
      ),
      child: Text(
        getTranslation(context, 'onboarding.login'),
        style: bold14LightBlack,
      ),
    );
  }

  nextButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          currentIndex++;
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: fixPadding),
        ),
      ),
      child: Text(
        getTranslation(context, 'onboarding.next'),
        style: bold14LightBlack,
      ),
    );
  }

  skipButton() {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: fixPadding),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Text(
        getTranslation(context, 'onboarding.skip'),
        style: bold14Grey,
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: blackColor,
          content: Text(
            getTranslation(context, 'app_exit.exit_text'),
            style: bold15White,
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1500),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
