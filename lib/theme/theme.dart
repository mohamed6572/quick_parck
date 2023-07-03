import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFD263);
const Color scaffoldBgColor = Color(0xFFF4F4F4);
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color lightBlackColor = Color(0xFF333333);
const Color greyColor = Color(0xFF949494);
const Color greyA1Color = Color(0xFFA1A1A1);
const Color greyD4Color = Color(0xFFD4D4D4);
const Color greyD9Color = Color(0xFFD9D9D9);
const Color textColor = Color(0xFFD1A32F);
const Color redColor = Color(0xFFBF2F2F);
const Color shadowColor = Color(0xFF030303);
const Color greenColor = Color(0xFF17900C);

const double fixPadding = 10.0;

const SizedBox heightSpace = SizedBox(height: fixPadding);
const SizedBox height5Space = SizedBox(height: fixPadding / 2);
const SizedBox widthSpace = SizedBox(width: fixPadding);
const SizedBox width5Space = SizedBox(width: fixPadding / 2);

SizedBox widthBox(double width) {
  return SizedBox(width: width);
}

SizedBox heightBox(double height) {
  return SizedBox(height: height);
}

BoxShadow boxShadow = BoxShadow(
  color: shadowColor.withOpacity(0.1),
  blurRadius: 10,
  offset: const Offset(0, 4),
);

BoxShadow buttonShadow = BoxShadow(
  color: primaryColor.withOpacity(0.1),
  blurRadius: 10,
  offset: const Offset(0, 4),
);

TextStyle semibold26Black = const TextStyle(
    color: blackColor, fontSize: 26, fontWeight: FontWeight.w600);

TextStyle semibold20Black = const TextStyle(
    color: blackColor, fontSize: 20, fontWeight: FontWeight.w600);

TextStyle semibold14Black = const TextStyle(
    color: blackColor, fontSize: 14, fontWeight: FontWeight.w600);

TextStyle semibold16Black = const TextStyle(
    color: blackColor, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle semibold30Black = const TextStyle(
    color: blackColor, fontSize: 30, fontWeight: FontWeight.w600);

TextStyle semibold15Grey = const TextStyle(
    color: greyColor, fontSize: 15, fontWeight: FontWeight.w600);

TextStyle semibold14Grey = const TextStyle(
    color: greyColor, fontSize: 14, fontWeight: FontWeight.w600);

TextStyle semibold15LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 15, fontWeight: FontWeight.w600);

TextStyle semibold18LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle semibold18TextColor = const TextStyle(
    color: textColor, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle semibold20Grey = const TextStyle(
    color: greyColor, fontSize: 20, fontWeight: FontWeight.w600);

TextStyle semibold12LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 12, fontWeight: FontWeight.w600);

TextStyle semibold16LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle semibold16Grey = const TextStyle(
    color: greyColor, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle semibold12Grey = const TextStyle(
    color: greyColor, fontSize: 12, fontWeight: FontWeight.w600);

TextStyle semibold14LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 14, fontWeight: FontWeight.w600);

TextStyle bold20LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 20, fontWeight: FontWeight.w700);

TextStyle bold15White = const TextStyle(
    color: whiteColor, fontSize: 15, fontWeight: FontWeight.w700);

TextStyle bold14LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 14, fontWeight: FontWeight.w700);

TextStyle bold16LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 16, fontWeight: FontWeight.w700);

TextStyle bold16Green = const TextStyle(
    color: greenColor, fontSize: 16, fontWeight: FontWeight.w700);

TextStyle bold15LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 15, fontWeight: FontWeight.w700);

TextStyle bold18LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 18, fontWeight: FontWeight.w700);

TextStyle bold18Red =
    const TextStyle(color: redColor, fontSize: 18, fontWeight: FontWeight.w700);

TextStyle bold15Red =
    const TextStyle(color: redColor, fontSize: 15, fontWeight: FontWeight.w700);

TextStyle bold15Green = const TextStyle(
    color: greenColor, fontSize: 15, fontWeight: FontWeight.w700);

TextStyle bold22LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 22, fontWeight: FontWeight.w700);

TextStyle bold18Grey = const TextStyle(
    color: greyColor, fontSize: 18, fontWeight: FontWeight.w700);

TextStyle bold14Grey = const TextStyle(
    color: greyColor, fontSize: 14, fontWeight: FontWeight.w700);

TextStyle bold15Grey = const TextStyle(
    color: greyColor, fontSize: 15, fontWeight: FontWeight.w700);

TextStyle bold16Grey = const TextStyle(
    color: greyColor, fontSize: 16, fontWeight: FontWeight.w700);

TextStyle bold12Grey = const TextStyle(
    color: greyColor, fontSize: 12, fontWeight: FontWeight.w700);

TextStyle bold12LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 12, fontWeight: FontWeight.w700);

TextStyle bold16TextColor = const TextStyle(
    color: textColor, fontSize: 16, fontWeight: FontWeight.w700);

TextStyle bold18TextColor = const TextStyle(
    color: textColor, fontSize: 18, fontWeight: FontWeight.w700);

TextStyle bold14TextColor = const TextStyle(
    color: textColor, fontSize: 14, fontWeight: FontWeight.w700);

TextStyle medium14LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 14, fontWeight: FontWeight.w500);

TextStyle medium15LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 15, fontWeight: FontWeight.w500);

TextStyle medium14Grey = const TextStyle(
    color: greyColor, fontSize: 14, fontWeight: FontWeight.w500);

TextStyle medium16Grey = const TextStyle(
    color: greyColor, fontSize: 16, fontWeight: FontWeight.w500);

TextStyle regular16LightBlack = const TextStyle(
    color: lightBlackColor, fontSize: 16, fontWeight: FontWeight.w400);
