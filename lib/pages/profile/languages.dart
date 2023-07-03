import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../widget/column_builder.dart';

int? languageValue;

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  SharedPreferences? prefs;
  final key = "value";

  @override
  void initState() {
    super.initState();
    _read();
  }

  _read() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      languageValue = prefs!.getInt(key) ?? 0;
    });
  }

  void _changeLanguges(String languageCode) async {
    Locale temp = await setLocale(languageCode);

    // ignore: use_build_context_synchronously
    MyApp.setLocale(context, temp);
  }

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
          getTranslation(context, 'languages.language'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
            top: fixPadding,
            bottom: fixPadding,
            left: fixPadding * 2.0,
            right: fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          languageList(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          updateButton(context),
        ],
      ),
    );
  }

  languageList() {
    return ColumnBuilder(
      itemCount: LanguagesList.languageList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              languageValue = index;
            });
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding * 1.2),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    LanguagesList.languageList[index].name.toString(),
                    style: semibold16LightBlack,
                  ),
                ),
                Container(
                  height: 22,
                  width: 22,
                  padding: const EdgeInsets.all(fixPadding / 1.7),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [boxShadow],
                    shape: BoxShape.circle,
                    border: languageValue == index
                        ? Border.all(
                            color: primaryColor,
                            width: 7,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  updateButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          for (int i = 0; i < LanguagesList.languageList.length; i++) {
            if (languageValue == i) {
              _changeLanguges(
                  LanguagesList.languageList[i].languageCode.toString());
            }
          }
        });
        prefs?.setInt(key, languageValue!);
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
          getTranslation(context, 'languages.update'),
          style: bold18LightBlack,
        ),
      ),
    );
  }
}

class LanguagesList {
  final int? id;
  final String? name;
  final String? languageCode;

  LanguagesList({this.id, this.languageCode, this.name});

  static List<LanguagesList> languageList = [
    LanguagesList(id: 1, name: "English", languageCode: 'en'),
    LanguagesList(id: 2, name: "हिन्दी", languageCode: 'hi'),
    LanguagesList(id: 3, name: "Indonesia", languageCode: 'id'),
    LanguagesList(id: 4, name: "中国人", languageCode: 'zh'),
    LanguagesList(id: 5, name: "عربي", languageCode: 'ar'),
  ];
}
