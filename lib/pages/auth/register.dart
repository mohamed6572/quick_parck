import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../profile/languages.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                registerText(),
                heightSpace,
                pleaseText(),
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                nameField(context),
                heightSpace,
                heightSpace,
                phoneField(context),
                heightSpace,
                heightSpace,
                emailField(context),
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                heightSpace,
                registerButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  registerButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/otp');
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
          getTranslation(context, 'register.register'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  emailField(BuildContext context) {
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
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding * 1.5, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 20,
              ),
              hintText: getTranslation(context, 'register.email_address'),
              hintStyle: bold16Grey),
        ),
      ),
    );
  }

  phoneField(BuildContext context) {
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
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding * 1.5, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.phone_android_outlined,
                size: 20,
              ),
              hintText: getTranslation(context, 'register.phone_number'),
              hintStyle: bold16Grey),
        ),
      ),
    );
  }

  nameField(BuildContext context) {
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
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding * 1.5, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
                size: 20,
              ),
              hintText: getTranslation(context, 'register.user_name'),
              hintStyle: bold16Grey),
        ),
      ),
    );
  }

  registerText() {
    return Text(
      getTranslation(context, 'register.user_name'),
      style: bold20LightBlack,
      textAlign: TextAlign.center,
    );
  }

  pleaseText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'register.please_text'),
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
