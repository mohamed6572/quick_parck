import '../../localization/localization_const.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class SelectVehicalScreen extends StatefulWidget {
  const SelectVehicalScreen({super.key});

  @override
  State<SelectVehicalScreen> createState() => _SelectVehicalScreenState();
}

class _SelectVehicalScreenState extends State<SelectVehicalScreen> {
  final vehicalList = [
    {
      "image": "assets/selectVehical/vehical1.png",
      "name": "Toyota corolla",
      "number": "HG4676FH"
    },

  ];

  int selectedIndex = 0;
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
          getTranslation(context, 'select_vehicle.select_vehicle'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.only(top: fixPadding, bottom: fixPadding * 2.0),
        children: [
          vehicalListContent(),
          heightSpace,
          heightSpace,
          heightSpace,
          addNewVehicalButton(),
        ],
      ),
      bottomNavigationBar: continueButton(context),
    );
  }

  continueButton(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 2.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/bookParkingDetail');
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(fixPadding * 1.4),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [buttonShadow],
            ),
            child: Text(
              getTranslation(context, 'select_vehicle.continue'),
              style: bold18LightBlack,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  addNewVehicalButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/addVehical');
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.4),
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: shadowColor.withOpacity(0.1),
            ),
            buttonShadow,
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'select_vehicle.add_vehicle'),
          style: bold18TextColor,
        ),
      ),
    );
  }

  vehicalListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
                vertical: fixPadding, horizontal: fixPadding * 1.5),
            margin: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [boxShadow],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Image.asset(
                  vehicalList[index]['image'].toString(),
                  height: 30,
                ),
                widthSpace,
                width5Space,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicalList[index]['name'].toString(),
                        style: bold15LightBlack,
                      ),
                      height5Space,
                      Text(
                        vehicalList[index]['number'].toString(),
                        style: semibold14Grey,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [boxShadow],
                    border: selectedIndex == index
                        ? Border.all(
                            color: primaryColor,
                            width: 7,
                          )
                        : null,
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: vehicalList.length,
    );
  }
}
