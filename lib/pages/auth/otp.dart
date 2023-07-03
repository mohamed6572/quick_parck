import 'dart:async';
import '../../localization/localization_const.dart';
import '../../pages/profile/languages.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../theme/theme.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    textStyle: bold20LightBlack,
    margin: const EdgeInsets.symmetric(horizontal: 7),
    width: 50,
    height: 50,
    constraints: const BoxConstraints(
        minHeight: 0, maxHeight: 50, minWidth: 0, maxWidth: 50),
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [boxShadow],
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          topCarImage(size),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                otpText(),
                heightSpace,
                confirmText(),
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                otpField(context),
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                verifyButton(),
                height5Space,
                resendButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  resendButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        getTranslation(context, 'otp.resend'),
        style: bold16Grey,
      ),
    );
  }

  verifyButton() {
    return GestureDetector(
      onTap: () {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/bottomBar');
        });
        pleaseDialog(context);
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
          getTranslation(context, 'otp.verify'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  otpField(BuildContext context) {
    return Form(
      key: formKey,
      child: Pinput(
        controller: pinController,
        focusNode: focusNode,
        cursor: Container(
          height: 18,
          width: 2,
          color: primaryColor,
        ),
        onCompleted: (value) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pushNamed(context, '/bottomBar')
                .then((value) => Navigator.pop(context));
          });
          pleaseDialog(context);
        },
        defaultPinTheme: defaultPinTheme,
      ),
    );
  }

  pleaseDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          contentPadding: const EdgeInsets.symmetric(
              vertical: fixPadding * 3.0, horizontal: fixPadding * 2.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  color: lightBlackColor,
                ),
              ),
              heightSpace,
              height5Space,
              Text(
                getTranslation(context, 'otp.please_wait'),
                style: semibold16LightBlack,
              )
            ],
          ),
        );
      },
    );
  }

  otpText() {
    return Text(
      getTranslation(context, 'otp.otp_title'),
      style: bold20LightBlack,
      textAlign: TextAlign.center,
    );
  }

  confirmText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'otp.confirmation_text'),
        textAlign: TextAlign.center,
        style: bold14Grey,
      ),
    );
  }

  topCarImage(Size size) {
    return Container(
      height: size.height * 0.29,
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
