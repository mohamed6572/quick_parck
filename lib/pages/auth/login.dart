import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  DateTime? backPressTime;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        body: Column(
          children: [
            topCarImage(size),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  loginText(),
                  heightSpace,
                  pleaseText(),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  EmailField(context),
                  heightSpace,
                  passwordField(context),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  loginButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loginButton() {
    return GestureDetector(
      onTap: () async{
        print('$email - $password');
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) {
         Navigator.pushNamed(context, '/bottomBar');
        print('login succses $value');
      }).catchError((e){
        print('faild to login => $e');
      });



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
          getTranslation(context, 'login.login'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  EmailField(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor)),
        child: TextField(
          cursorColor: primaryColor,
          controller: email,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding * 1.5, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 20,
              ),
              hintText: getTranslation(context, 'login.phone_number'),
              hintStyle: bold16Grey),
        ),
      ),
    );
  }
  passwordField(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor)),
        child: TextField(
          cursorColor: primaryColor,
          controller: password,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding * 1.5, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.phone_android_outlined,
                size: 20,
              ),
              hintText: getTranslation(context, 'login.password'),
              hintStyle: bold16Grey),
        ),
      ),
    );
  }

  loginText() {
    return Text(
      getTranslation(context, 'login.login'),
      style: bold20LightBlack,
      textAlign: TextAlign.center,
    );
  }

  pleaseText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'login.please_text'),
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
