import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          getTranslation(context, 'help_support.help_support'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          helpContenDetail(size),
          quickContentDetail(context, size),
        ],
      ),
    );
  }

  quickContentDetail(BuildContext context, Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [boxShadow],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
              left: fixPadding * 2.0,
              right: fixPadding * 2.0,
              bottom: fixPadding * 2.0,
              top: fixPadding * 1.2),
          children: [
            Text(
              getTranslation(context, 'help_support.quick_contact'),
              style: bold18LightBlack,
              textAlign: TextAlign.center,
            ),
            heightSpace,
            heightSpace,
            nameField(context),
            heightSpace,
            heightSpace,
            emailField(context),
            heightSpace,
            heightSpace,
            messageField(context, size),
            heightSpace,
            heightSpace,
            heightSpace,
            heightSpace,
            sendButton(context)
          ],
        ),
      ),
    );
  }

  sendButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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
          getTranslation(context, 'help_support.send'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  messageField(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'help_support.message'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
          height: size.height * 0.2,
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
              expands: true,
              maxLines: null,
              minLines: null,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText:
                    getTranslation(context, 'help_support.write_message_here'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  emailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'help_support.email_address'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
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
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText:
                    getTranslation(context, 'help_support.enter_email_address'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  nameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'help_support.name'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
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
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText: getTranslation(context, 'help_support.enter_name'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  helpContenDetail(Size size) {
    return Padding(
      padding: const EdgeInsets.only(
          left: fixPadding * 2.0,
          right: fixPadding * 2.0,
          bottom: fixPadding * 2.0,
          top: fixPadding),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/profile/image.png",
              height: size.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: fixPadding, horizontal: fixPadding),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [boxShadow],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call_outlined,
                        size: 20,
                        color: Color(0xFF5C7CCD),
                      ),
                      width5Space,
                      Expanded(
                        child: Text(
                          getTranslation(context, 'help_support.call_us'),
                          style: bold16LightBlack.copyWith(
                              color: const Color(0xFF5C7CCD),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: fixPadding, horizontal: fixPadding),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [boxShadow],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail_outline_outlined,
                        size: 20,
                        color: greenColor,
                      ),
                      width5Space,
                      Expanded(
                        child: Text(
                          getTranslation(context, 'help_support.mail_us'),
                          style: bold16Green,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
