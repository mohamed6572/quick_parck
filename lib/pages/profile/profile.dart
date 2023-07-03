import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_parck/constants/user_data.dart';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          getTranslation(context, 'profile.profile'),
          style: bold20LightBlack,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          userDetail(size),
          heightSpace,
          profileListTile(getTranslation(context, 'profile.wallet'),
              Icons.account_balance_wallet_outlined, () {
            Navigator.pushNamed(context, '/wallet');
          }, isWallet: true),
          profileListTile(getTranslation(context, 'profile.my_vehicle'),
              Icons.directions_car_filled_outlined, () {
            Navigator.pushNamed(context, '/myVehicle');
          }),
          profileListTile(getTranslation(context, 'profile.help_support'),
              Icons.help_outline_rounded, () {
            Navigator.pushNamed(context, '/helpAndSupport');
          }),
          profileListTile(getTranslation(context, 'profile.privacy_policy'),
              Icons.privacy_tip_outlined, () {
            Navigator.pushNamed(context, '/privacyPolicy');
          }),
          profileListTile(getTranslation(context, 'profile.terms_condition'),
              Icons.list_alt_rounded, () {
            Navigator.pushNamed(context, '/termsCondition');
          }),
          profileListTile(
              getTranslation(context, 'profile.language'), CupertinoIcons.globe,
              () {
            Navigator.pushNamed(context, '/languages');
          }),
          profileListTile(getTranslation(context, 'profile.app_settings'),
              CupertinoIcons.gear_alt, () {
            Navigator.pushNamed(context, '/appSettings');
          }),
          profileListTile(
              getTranslation(context, 'profile.logout'), Icons.logout, () {
            logoutDialog(context);
          }, color: redColor),
          heightSpace,
        ],
      ),
    );
  }

  logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getTranslation(context, 'profile.logout'),
                  style: bold18Red,
                ),
                heightSpace,
                Text(
                  getTranslation(context, 'profile.sure_text'),
                  style: semibold18LightBlack,
                  textAlign: TextAlign.center,
                ),
                heightSpace,
                heightSpace,
                Row(
                  children: [
                    Expanded(
                      child: buttonWidget(
                        getTranslation(context, 'profile.no'),
                        () {
                          Navigator.pop(context);
                        },
                        whiteColor,
                        textColor,
                      ),
                    ),
                    widthSpace,
                    widthSpace,
                    Expanded(
                      child: buttonWidget(
                        getTranslation(context, 'profile.yes_logout'),
                        () {
                          setState(() {
                            FirebaseAuth.instance.signOut();
                          });

                          Navigator.pushNamed(context, '/login');
                        },
                        primaryColor,
                        lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buttonWidget(String title, Function() onTap, Color color, Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding, vertical: fixPadding * 1.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [boxShadow],
          color: color,
        ),
        child: Text(
          title,
          style: bold18TextColor.copyWith(color: textColor),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  profileListTile(title, icon, Function() onTap,
      {bool isWallet = false, Color color = lightBlackColor}) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 0,
      leading: Icon(
        icon,
        color: color,
        size: 22,
      ),
      title: Text(
        title,
        style: bold16LightBlack.copyWith(color: color),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isWallet == true
              ? Text(
                  "\$500",
                  style: bold16Green,
                )
              : const SizedBox(),
          widthSpace,
          const Icon(
            Icons.arrow_forward_ios,
            size: 19,
            color: lightBlackColor,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
      ),
    );
  }

  userDetail(Size size) {
    return Container(
      color: const Color(0xFFE8E6E6),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            height: size.height * 0.13,
            width: size.height * 0.13,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("$image"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$Name",
                  style: bold16LightBlack,
                ),
                height5Space,
                Text(
                  "$email",
                  style: bold14Grey,
                ),
                height5Space,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: fixPadding * 0.7,
                        horizontal: fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      getTranslation(context, 'profile.edit_profile'),
                      style: bold16LightBlack,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
