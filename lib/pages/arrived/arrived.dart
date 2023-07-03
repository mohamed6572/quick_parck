import '../../pages/profile/languages.dart';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import '../../widget/column_builder.dart';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ArrivedScreen extends StatefulWidget {
  const ArrivedScreen({super.key});

  @override
  State<ArrivedScreen> createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [topCarImage(size), arrivedDetail(size)],
      ),
    );
  }

  arrivedDetail(Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Image.asset(
              "assets/arrived/location.png",
              height: size.width * 0.25,
              width: size.width * 0.25,
            ),
          ),
          heightSpace,
          heightSpace,
          Text(
            getTranslation(context, 'arrived.you_arrived'),
            style: bold22LightBlack,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          Text(
            getTranslation(context, 'arrived.text'),
            style: semibold16Grey,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          okayButton(size),
        ],
      ),
    );
  }

  okayButton(Size size) {
    return GestureDetector(
      onTap: () {
        successDialog(size);
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [buttonShadow],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'arrived.okay'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  successDialog(Size size) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 3.0, vertical: fixPadding * 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: whiteColor,
            child: Container(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/arrived/success.png",
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                  ),
                  heightSpace,
                  heightSpace,
                  Text(
                    getTranslation(context, 'arrived.scan_ticket_success'),
                    style: bold22LightBlack,
                  ),
                  heightSpace,
                  Text(
                    getTranslation(context, 'arrived.countdown_text'),
                    style: semibold16Grey,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/parkingTime')
                          .then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(fixPadding * 1.4),
                      margin:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [buttonShadow],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        getTranslation(context, 'arrived.okay'),
                        style: bold18LightBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  topCarImage(Size size) {
    return Container(
      height: size.height * 0.3,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/auth/car.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.85, 1.0],
            colors: [
              whiteColor.withOpacity(0),
              greyA1Color,
            ],
          ),
        ),
        alignment: languageValue == 4 ? Alignment.topRight : Alignment.topLeft,
        child: IconButton(
          padding: const EdgeInsets.only(
              top: fixPadding * 3.5,
              left: fixPadding * 2.0,
              right: fixPadding * 2.0,
              bottom: fixPadding * 2.0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightBlackColor,
          ),
        ),
      ),
    );
  }
}
