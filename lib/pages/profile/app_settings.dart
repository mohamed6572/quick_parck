import '../../localization/localization_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool notificationValue = true;

  bool locationValue = true;

  bool updateValue = true;
  bool themeValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: scaffoldBgColor,
        titleSpacing: 0.0,
        shadowColor: shadowColor.withOpacity(0.25),
        foregroundColor: lightBlackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          getTranslation(context, 'app_settings.app_settings'),
          style: bold18LightBlack,
        ),
      ),
      body: settingListContent(),
    );
  }

  settingListContent() {
    return ListView(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      physics: const BouncingScrollPhysics(),
      children: [
        settingWidget(
          getTranslation(context, 'app_settings.notification'),
          notificationValue,
          (value) {
            setState(() {
              notificationValue = !notificationValue;
            });
          },
        ),
        heightSpace,
        heightSpace,
        settingWidget(
          getTranslation(context, 'app_settings.location'),
          locationValue,
          (value) {
            setState(() {
              locationValue = !locationValue;
            });
          },
        ),
        heightSpace,
        heightSpace,
        settingWidget(
          getTranslation(context, 'app_settings.application_update'),
          updateValue,
          (value) {
            setState(() {
              updateValue = !updateValue;
            });
          },
        ),
        heightSpace,
        heightSpace,
        settingWidget(
          getTranslation(context, 'app_settings.dark_mode'),
          themeValue,
          (value) {
            setState(() {
              themeValue = !themeValue;
            });
          },
        ),
      ],
    );
  }

  settingWidget(title, switchvalue, Function(bool) onChange) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: semibold16Black,
              ),
            ),
            CupertinoSwitch(
                activeColor: primaryColor,
                trackColor: const Color(0xFFB7B7B7),
                value: switchvalue,
                onChanged: onChange)
          ],
        ),
        height5Space,
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing Senectus pellentesque justo, quis varius dictumst ",
          style: semibold14Grey,
        )
      ],
    );
  }
}
