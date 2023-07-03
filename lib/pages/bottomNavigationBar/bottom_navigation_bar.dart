import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_parck/constants/user_data.dart';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MyBooking/my_booking.dart';
import '../boomark/book_mark.dart';
import '../home/home.dart';
import '../profile/profile.dart';
import '../screens.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  int selectedIndex = 0;

  DateTime? backPressTime;

  final pages = [
    const HomeScreen(),
    const MyBookingScreen(),
    const BookMarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: scaffoldBgColor,
        body: pages.elementAt(selectedIndex),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }

  bottomBar() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: whiteColor,
      currentIndex: selectedIndex,
      selectedItemColor: lightBlackColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: bold14LightBlack,
      unselectedLabelStyle: bold14Grey,
      unselectedItemColor: greyColor,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.placemark),
            label: getTranslation(context, 'bottomBar.near_by')),
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.ticket),
            label: getTranslation(context, 'bottomBar.booking')),
        BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_border_rounded),
            label: getTranslation(context, 'bottomBar.saved')),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: getTranslation(context, 'bottomBar.pofile'))
      ],
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
