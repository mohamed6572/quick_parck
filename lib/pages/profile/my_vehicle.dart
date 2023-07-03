import '../../localization/localization_const.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key});

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen> {
  final vehicalList = [
    {
      "image": "assets/selectVehical/vehical1.png",
      "name": "Toyota corolla",
      "number": "HG4676FH"
    },
    {
      "image": "assets/selectVehical/vehical3.png",
      "name": "For Fseries",
      "number": "HG4676FH"
    },
    {
      "image": "assets/selectVehical/vehical2.png",
      "name": "Kia EV6",
      "number": "HG4676FH"
    }
  ];
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
          getTranslation(context, 'my_vehicle.my_vehicle'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding),
        children: [
          vehicleListContent(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          addNewVehicalButton(),
        ],
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
          getTranslation(context, 'my_vehicle.add_new_vehicle'),
          style: bold18TextColor,
        ),
      ),
    );
  }

  vehicleListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
              vertical: fixPadding, horizontal: fixPadding * 1.5),
          margin: const EdgeInsets.symmetric(vertical: fixPadding),
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
            ],
          ),
        );
      },
      itemCount: vehicalList.length,
    );
  }
}
