import 'package:dotted_border/dotted_border.dart';
import '../../constants/user_data.dart';
import '../../localization/localization_const.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SelectSlotScreen extends StatefulWidget {
  const SelectSlotScreen({super.key});

  @override
  State<SelectSlotScreen> createState() => _SelectSlotScreenState();
}

class _SelectSlotScreenState extends State<SelectSlotScreen> {
  final List floor = ["1st Floor", "2nd Floor", "3th Floor", "4th Floor"];



  final List bSlotList = [

  ];

  int selectedFloor = 0;

  int selectedindex = 10;

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
          getTranslation(context, 'select_slot.select_slot'),
          style: bold18LightBlack,
        ),
      ),
      body: Column(
        children: [
          height5Space,
          floorList(),
          heightSpace,
          Expanded(
            child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  left: fixPadding * 2.0, right: fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    aSlotListContent(),
                   // entryLine(),
                    //bSlotListContent()
                  ],
                ),
                exitText(),
                heightSpace,
              ],
            ),
          ),

          proceedButton(),
        ],
      ),
    );
  }

  exitText() {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DottedBorder(
                  padding: EdgeInsets.zero,
                  dashPattern: const [2, 5],
                  color: const Color(0xFF757897),
                  child: Container(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding, vertical: fixPadding / 2),
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6E3B3),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslation(context, 'select_slot.exit'),
                  style: bold12LightBlack,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  entryLine() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding, vertical: fixPadding / 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF6E3B3),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              getTranslation(context, 'select_slot.entry'),
              style: bold12LightBlack,
            ),
          ),
          heightSpace,
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor,
                width: 4,
              ),
            ),
          ),
          DottedBorder(
            padding: EdgeInsets.zero,
            dashPattern: const [2, 4],
            color: const Color(0xFF757897),
            child: const SizedBox(
              height: 500,
              width: 0,
            ),
          )
        ],
      ),
    );
  }
  //
  // bSlotListContent() {
  //   return Expanded(
  //       flex: 2,
  //       child: Column(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
  //             decoration: BoxDecoration(
  //               color: const Color(0xFFF6E3B3),
  //               borderRadius: BorderRadius.circular(4.0),
  //             ),
  //             child: Text(
  //               "B",
  //               style: bold16LightBlack,
  //             ),
  //           ),
  //           height5Space,
  //           heightSpace,
  //           divider(),
  //           ColumnBuilder(
  //               itemBuilder: (context, index) {
  //                 return Column(
  //                   children: [
  //                     Container(
  //                       padding:
  //                           const EdgeInsets.symmetric(vertical: fixPadding),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             bSlotList[index]['name'],
  //                             style: bold15LightBlack,
  //                           ),
  //                           bSlotList[index]['AlreadyBooking'] == true
  //                               ? Image.asset(
  //                                   "assets/selectVehical/vehical1.png",
  //                                   height: 30,
  //                                   width: 50,
  //                                 )
  //                               : GestureDetector(
  //                                   onTap: () {
  //                                     setState(() {
  //                                       selectedindex = bSlotList[index]['id'];
  //                                     });
  //                                   },
  //                                   child: Container(
  //                                     height: 30,
  //                                     width: 50,
  //                                     decoration: BoxDecoration(
  //                                       color: selectedindex ==
  //                                               bSlotList[index]['id']
  //                                           ? primaryColor
  //                                           : whiteColor,
  //                                       borderRadius:
  //                                           BorderRadius.circular(5.0),
  //                                       border: Border.all(color: primaryColor),
  //                                     ),
  //                                   ),
  //                                 ),
  //                         ],
  //                       ),
  //                     ),
  //                     divider(),
  //                   ],
  //                 );
  //               },
  //               itemCount: bSlotList.length)
  //         ],
  //       ));
  // }

  aSlotListContent() {
    return Expanded(
        flex: 2,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF6E3B3),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                "A",
                style: bold16LightBlack,
              ),
            ),
            height5Space,
            heightSpace,
            divider(),
            ColumnBuilder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: fixPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            aSlotList[index]['AlreadyBooking'] == true
                                ? Image.asset(
                                    "assets/selectVehical/vehical1.png",
                                    height: 30,
                                    width: 50,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedindex = aSlotList[index]['id'];

                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: selectedindex ==
                                                aSlotList[index]['id']
                                            ? primaryColor
                                            : whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(color: primaryColor),
                                      ),
                                    ),
                                  ),
                            Text(
                              aSlotList[index]['name'],
                              style: bold15LightBlack,
                            ),
                          ],
                        ),
                      ),
                      divider(),
                    ],
                  );
                },
                itemCount: aSlotList.length)
          ],
        ));
  }

  divider() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      dashPattern: const [2, 4],
      color: const Color(0xFF757897),
      child: Container(),
    );
  }

  proceedButton() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
          left: fixPadding * 2.0,
          right: fixPadding * 2.0,
          bottom: fixPadding * 2.0,
          top: fixPadding),
      child: GestureDetector(
        onTap: () {

          if( aSlotList[0]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[3]['AlreadyBooking']!=true) {
            updateDocument(selectedindex);
            setState(() {

slot=aSlotList[selectedindex]['name'];
              getSlots();
            });
            Navigator.pushNamed(context, '/paymentMethods');
          }
        },
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(fixPadding * 1.4),
          decoration: BoxDecoration(
            color:( aSlotList[0]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[3]['AlreadyBooking']!=true)? primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [buttonShadow],
          ),
          alignment: Alignment.center,
          child: Text(
          ( aSlotList[0]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[1]['AlreadyBooking']!=true||aSlotList[3]['AlreadyBooking']!=true)?getTranslation(context, 'select_slot.proceed_slot'):'NO Slots',
            style: bold18LightBlack,
          ),
        ),
      ),
    );
  }

  floorList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(fixPadding * 1.5),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          floor.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFloor = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding, vertical: fixPadding * 0.7),
                decoration: BoxDecoration(
                    color: selectedFloor == index ? primaryColor : null,
                    borderRadius: BorderRadius.circular(5.0),
                    border: selectedFloor == index
                        ? null
                        : Border.all(color: primaryColor)),
                child: Text(
                  floor[index],
                  style: bold14LightBlack,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
