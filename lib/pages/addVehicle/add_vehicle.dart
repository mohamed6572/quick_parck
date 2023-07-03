
import 'package:flutter/material.dart';

import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import '../../widget/column_builder.dart';

class AddVehicalScreen extends StatefulWidget {
  const AddVehicalScreen({super.key});

  @override
  State<AddVehicalScreen> createState() => _AddVehicalScreenState();
}

class _AddVehicalScreenState extends State<AddVehicalScreen> {
  final vehicalTypeList = ["Hatchback", "Sedan", "SUV", "Lowrider"];

  String? vehicalTypeName;

  final vehicalNameList = [
    {"image": "assets/addVehical/yellowCar.png", "name": "Tata Nexon"},
    {"image": "assets/addVehical/purpleCar.png", "name": "Honda e"},
    {"image": "assets/addVehical/greenCar.png", "name": "Volvo XC40 Recharge"},
    {"image": "assets/addVehical/purpleCar.png", "name": "Kia EV6"},
    {"image": "assets/addVehical/yellowCar.png", "name": "BMW i4"},
    {"image": "assets/addVehical/greenCar.png", "name": "MG ZS EV"},
    {"image": "assets/addVehical/purpleCar.png", "name": "Porsche Taycan"},
    {"image": "assets/addVehical/whiteCar.png", "name": "Jaguar I-Pace"},
    {"image": "assets/addVehical/yellowCar.png", "name": "Porsche Taycan"},
    {"image": "assets/addVehical/cyanCar.png", "name": "BMW iX"},
    {"image": "assets/addVehical/greenCar.png", "name": "Tesla"},
    {"image": "assets/addVehical/yellowCar.png", "name": "Mercedes-Benz "},
    {"image": "assets/addVehical/purpleCar.png", "name": "Mini Cooper SE"},
  ];

  String? vehicalname;

  @override
  void initState() {
    vehicalTypeName = vehicalTypeList[0];
    vehicalname = vehicalNameList[3]['name'];
    super.initState();
  }

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
          getTranslation(context, 'add_vehicle.add_vehicle'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          vehicalType(),
          heightSpace,
          heightSpace,
          vehicalName(size),
          heightSpace,
          heightSpace,
          vehicalRegisterNumber(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          addButton(context)
        ],
      ),
    );
  }

  addButton(BuildContext context) {
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
        child: Text(
          getTranslation(context, 'add_vehicle.add'),
          style: bold18LightBlack,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  vehicalRegisterNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'add_vehicle.vehicle_number'),
          style: semibold16Grey,
        ),
        heightSpace,
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.2),
                blurRadius: 6,
              )
            ],
          ),
          child: TextField(
            style: semibold15LightBlack,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(fixPadding * 1.5),
              hintText:
                  getTranslation(context, 'add_vehicle.enter_vehical_number'),
            ),
          ),
        )
      ],
    );
  }

  vehicalName(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'add_vehicle.vehicle_name'),
          style: semibold16Grey,
        ),
        heightSpace,
        GestureDetector(
          onTap: () {
            vehicalNameBottomsheet(size);
          },
          child: Container(
            padding: const EdgeInsets.all(fixPadding * 1.5),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.2),
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    vehicalname.toString(),
                    style: semibold15LightBlack,
                  ),
                ),
                width5Space,
                const Icon(
                  Icons.arrow_drop_down,
                  color: blackColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  vehicalNameBottomsheet(Size size) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxHeight: size.height * 0.9),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(fixPadding * 2.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Text(
                getTranslation(context, 'add_vehicle.vehicle_name'),
                style: bold16LightBlack,
                textAlign: TextAlign.center,
              ),
              heightSpace,
              height5Space,
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [boxShadow],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          const ColorScheme.light(primary: primaryColor)),
                  child: TextField(
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 1.5,
                            horizontal: fixPadding * 1.2),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        hintText: getTranslation(
                            context, 'add_vehicle.search_vehicle'),
                        hintStyle: bold16Grey),
                  ),
                ),
              ),
              heightSpace,
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          vehicalname = vehicalNameList[index]['name'];
                        });

                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: fixPadding / 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixPadding, vertical: fixPadding * 1.1),
                        decoration:
                            vehicalname == vehicalNameList[index]['name']
                                ? BoxDecoration(
                                    color: const Color(0xFFFEF4DA),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: primaryColor))
                                : const BoxDecoration(),
                        child: Row(
                          children: [
                            Image.asset(
                              vehicalNameList[index]['image'].toString(),
                              height: 26,
                              fit: BoxFit.cover,
                            ),
                            widthSpace,
                            Expanded(
                                child: Text(
                              vehicalNameList[index]['name'].toString(),
                              style: semibold14Black,
                            )),
                            widthSpace,
                            vehicalname == vehicalNameList[index]['name']
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: whiteColor,
                                      size: 13,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: vehicalNameList.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  vehicalType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'add_vehicle.vehicle_type'),
          style: semibold16Grey,
        ),
        heightSpace,
        GestureDetector(
          onTap: () {
            vehicalTypeBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(fixPadding * 1.5),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.2),
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    vehicalTypeName.toString(),
                    style: semibold15LightBlack,
                  ),
                ),
                width5Space,
                const Icon(
                  Icons.arrow_drop_down,
                  color: blackColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  vehicalTypeBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(fixPadding * 2.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                getTranslation(context, 'add_vehicle.vehicle_type'),
                style: bold16LightBlack,
                textAlign: TextAlign.center,
              ),
              heightSpace,
              height5Space,
              ColumnBuilder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        vehicalTypeName = vehicalTypeList[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: fixPadding / 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding, vertical: fixPadding * 1.1),
                      decoration: vehicalTypeName == vehicalTypeList[index]
                          ? BoxDecoration(
                              color: const Color(0xFFFEF4DA),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: primaryColor))
                          : const BoxDecoration(),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            vehicalTypeList[index],
                            style: semibold14Black,
                          )),
                          widthSpace,
                          vehicalTypeName == vehicalTypeList[index]
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: whiteColor,
                                    size: 13,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: vehicalTypeList.length,
              )
            ],
          ),
        );
      },
    );
  }
}
