import '../../constants/user_data.dart';
import '../../localization/localization_const.dart';
import '../../pages/profile/languages.dart';
import '../../theme/theme.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }



  List bookingHistory = [


  ];

  int currentIndex = 3;

  _buildStar(int index, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding / 4),
      child: InkWell(
        onTap: () {
          state(() {
            setState(() {
              currentIndex = index;
            });
          });
        },
        child: Icon(
          Icons.star_rounded,
          color:
              (currentIndex >= index) ? primaryColor : const Color(0xFFBAB3B3),
          size: 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Text(
          getTranslation(context, 'my_booking.my_booking'),
          style: bold20LightBlack,
        ),
      ),
      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Text(
                  'Paid',
                  style: bold16LightBlack,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [

                ongoingList!.isEmpty
                    ? emptyBookingListContent()
                    : ongoingListContent(size),
                bookingHistoryListContent(size)
              ],
            ),
          )
        ],
      ),
    );
  }

  bookingHistoryListContent(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      itemCount: bookingHistory.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: fixPadding),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [boxShadow],
            color: whiteColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Row(
                  children: [
                    Container(
                      height: size.width * 0.2,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [boxShadow],
                        image: DecorationImage(
                          image: AssetImage(
                            bookingHistory[index]['image'].toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: textColor,
                              size: 16,
                            ),
                            widthBox(3.0),
                            Text(
                              bookingHistory[index]['rate'].toString(),
                              style: semibold14LightBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookingHistory[index]['name'].toString(),
                            style: semibold16LightBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            bookingHistory[index]['description'].toString(),
                            style: semibold14Grey,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            bookingHistory[index]['date'].toString(),
                            style: semibold14Grey,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text.rich(
                            TextSpan(
                                text: "${bookingHistory[index]['total_price']}/",
                                style: semibold16LightBlack,
                                children: [
                                  TextSpan(
                                      text:
                                          "${bookingHistory[index]['duration']} ${getTranslation(context, 'my_booking.hour')}",
                                      style: semibold12Grey)
                                ]),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  giveRateButton(size),
                  viewTicketButton(() {
                    Navigator.pushNamed(context, '/parkingTicket',
                        arguments: {"id": 0});
                  }),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  emptyBookingListContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/myBooking/emojione_disappointed-face.png",
            height: 35,
            width: 35,
          ),
          heightSpace,
          Text(getTranslation(context, 'my_booking.no_booking_yet'),
              style: bold18Grey)
        ],
      ),
    );
  }

  ongoingListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      physics: const BouncingScrollPhysics(),
      itemCount: ongoingList!.length,
      itemBuilder: (context, index) {
        final itemData = ongoingList![index];
        return Padding(
          padding: EdgeInsets.only(bottom: index == 0 ? fixPadding : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: const EdgeInsets.symmetric(vertical: fixPadding),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [boxShadow],
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(fixPadding),
                      child: Row(
                        children: [
                          Container(
                            height: size.width * 0.2,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [boxShadow],
                              image: DecorationImage(
                                image: NetworkImage(
                                  itemData['image'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: const BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: textColor,
                                    size: 16,
                                  ),
                                  widthBox(3.0),
                                  Text(
                                    itemData['rate'].toString(),
                                    style: semibold14LightBlack,
                                  )
                                ],
                              ),
                            ),
                          ),
                          widthSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemData['name'].toString(),
                                  style: semibold16LightBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  itemData['description'].toString(),
                                  style: semibold14Grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  itemData['date'].toString(),
                                  style: semibold14Grey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: "\$${itemData['total_price']}/",
                                      style: semibold16LightBlack,
                                      children: [
                                        TextSpan(
                                            text:
                                            "${itemData['duration']} ${getTranslation(context, 'my_booking.hour')}",
                                            style: semibold12Grey)
                                      ]),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        false ==
                            getTranslation(
                                context, 'my_booking.active_now')
                            ? viewTimerButton()
                            : cancelBookingButton(index),
                        viewTicketButton(() {
                          Navigator.pushNamed(context, '/parkingTicket',
                              arguments: {"id": index});
                        })
                      ],
                    )
                  ],
                ),
              ),
              // ColumnBuilder(
              //   itemBuilder: (context, dataIndex) {
              //
              //     return Container(
              //       margin: const EdgeInsets.symmetric(vertical: fixPadding),
              //       width: double.maxFinite,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10.0),
              //         boxShadow: [boxShadow],
              //         color: whiteColor,
              //       ),
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(fixPadding),
              //             child: Row(
              //               children: [
              //                 Container(
              //                   height: size.width * 0.2,
              //                   width: size.width * 0.25,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(5.0),
              //                     boxShadow: [boxShadow],
              //                     image: DecorationImage(
              //                       image: NetworkImage(
              //                         itemData['image'].toString(),
              //                       ),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   alignment: Alignment.bottomRight,
              //                   child: Container(
              //                     padding: const EdgeInsets.all(3.0),
              //                     decoration: const BoxDecoration(
              //                       color: whiteColor,
              //                       borderRadius: BorderRadius.only(
              //                         bottomRight: Radius.circular(5.0),
              //                       ),
              //                     ),
              //                     child: Row(
              //                       mainAxisSize: MainAxisSize.min,
              //                       children: [
              //                         const Icon(
              //                           Icons.star,
              //                           color: textColor,
              //                           size: 16,
              //                         ),
              //                         widthBox(3.0),
              //                         Text(
              //                           itemData['rate'].toString(),
              //                           style: semibold14LightBlack,
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 widthSpace,
              //                 Expanded(
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         itemData['name'].toString(),
              //                         style: semibold16LightBlack,
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                       Text(
              //                         itemData['description'].toString(),
              //                         style: semibold14Grey,
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                       Text(
              //                         itemData['date'].toString(),
              //                         style: semibold14Grey,
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                       Text.rich(
              //                         TextSpan(
              //                             text: "\$${itemData['total_price']}/",
              //                             style: semibold16LightBlack,
              //                             children: [
              //                               TextSpan(
              //                                   text:
              //                                       "${itemData['duration']} ${getTranslation(context, 'my_booking.hour')}",
              //                                   style: semibold12Grey)
              //                             ]),
              //                         overflow: TextOverflow.ellipsis,
              //                       )
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           Row(
              //             children: [
              //               false ==
              //                       getTranslation(
              //                           context, 'my_booking.active_now')
              //                   ? viewTimerButton()
              //                   : cancelBookingButton(index, dataIndex),
              //               viewTicketButton(() {
              //                 Navigator.pushNamed(context, '/parkingTicket',
              //                     arguments: {"id": index});
              //               })
              //             ],
              //           )
              //         ],
              //       ),
              //     );
              //   },
              //   itemCount: ongoingList!.length,
              // )
            ],
          ),
        );
      },
    );
  }

  viewTicketButton(Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(
            fixPadding,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: languageValue == 4
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                  )
                : const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                  ),
            boxShadow: [boxShadow],
          ),
          alignment: Alignment.center,
          child: Text(
            getTranslation(context, 'my_booking.view_ticket'),
            style: bold16LightBlack,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  cancelBookingButton(index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
        setState(() {
          deleteBooking(index);
        });
         //cancelBookingBottomSheet(item, dataIndex, index);
        },
        child: Container(
          padding: const EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: languageValue == 4
                ? const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                  ),
            boxShadow: [boxShadow],
          ),
          alignment: Alignment.center,
          child: Text(
            getTranslation(context, 'my_booking.cancel_booking'),
            style: bold16TextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  cancelBookingBottomSheet(item, dataIndex, index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            color: whiteColor,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              heightSpace,
              Center(
                child: Container(
                  height: 1,
                  width: 60,
                  color: greyD9Color,
                ),
              ),
              heightSpace,
              heightSpace,
              Text(
                getTranslation(context, 'my_booking.cancel_booking'),
                style: bold18Red,
                textAlign: TextAlign.center,
              ),
              heightSpace,
              heightSpace,
              Container(
                height: 1,
                width: double.maxFinite,
                color: greyD4Color,
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  children: [
                    Text(
                      getTranslation(
                          context, 'my_booking.are_you_sure_message'),
                      style: semibold18LightBlack,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    height5Space,
                    Text(
                      getTranslation(context, 'my_booking.content'),
                      style: medium14Grey,
                      textAlign: TextAlign.center,
                    ),
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: buttonWidget(
                            getTranslation(context, 'my_booking.close'),
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
                            getTranslation(context, 'my_booking.yes_continue'),
                            () {
                              setState(() {
                                item['data'].removeAt(dataIndex);
                              });

                              if (item['data']!.length == 0) {
                                setState(() {
                                  ongoingList!.removeAt(index);
                                });
                              }
                              Navigator.pop(context);
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
            ],
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

  giveRateButton(Size size) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          giveRateBottomSheet(size);
        },
        child: Container(
          padding: const EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: languageValue == 4
                ? const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                  ),
            boxShadow: [boxShadow],
          ),
          alignment: Alignment.center,
          child: Text(
            getTranslation(context, 'my_booking.give_rate'),
            style: bold16TextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  giveRateBottomSheet(Size size) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              color: whiteColor,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  bottom: fixPadding * 2.0,
                  top: fixPadding * 1.5,
                  left: fixPadding * 2.0,
                  right: fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Container(
                    height: 1,
                    width: 60,
                    color: greyD9Color,
                  ),
                ),
                heightSpace,
                heightSpace,
                Text(
                  getTranslation(context, 'my_booking.your_review'),
                  style: bold18TextColor,
                  textAlign: TextAlign.center,
                ),
                heightSpace,
                height5Space,
                Text(
                  getTranslation(context, 'my_booking.please_text'),
                  style: semibold18LightBlack,
                  textAlign: TextAlign.center,
                ),
                heightSpace,
                heightSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 5; i++) _buildStar(i, state),
                  ],
                ),
                heightSpace,
                heightSpace,
                Container(
                  height: size.height * 0.15,
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
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: fixPadding * 1.5,
                            horizontal: fixPadding * 1.2),
                        border: InputBorder.none,
                        hintText:
                            getTranslation(context, 'my_booking.say_something'),
                        hintStyle: medium16Grey,
                      ),
                    ),
                  ),
                ),
                heightSpace,
                heightSpace,
                heightSpace,
                Row(
                  children: [
                    Expanded(
                      child: buttonWidget(
                        getTranslation(context, 'my_booking.remind_later'),
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
                        getTranslation(context, 'my_booking.send'),
                        () {
                          Navigator.pop(context);
                        },
                        primaryColor,
                        lightBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  viewTimerButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/parkingTime');
        },
        child: Container(
          padding: const EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: languageValue == 4
                ? const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                  ),
            boxShadow: [boxShadow],
          ),
          alignment: Alignment.center,
          child: Text(
            getTranslation(context, 'my_booking.view_timer'),
            style: bold16TextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  tabBar() {
    return Stack(
      children: [
        Container(
          height: 40,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: greyD9Color, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: double.maxFinite,
          child: TabBar(
            controller: tabController,
            indicatorColor: lightBlackColor,
            labelStyle: bold16LightBlack,
            unselectedLabelStyle: bold16Grey,
            unselectedLabelColor: greyColor,
            labelColor: lightBlackColor,
            tabs: [
              Tab(text: getTranslation(context, 'my_booking.ongoing_booking')),
              Tab(text: getTranslation(context, 'my_booking.booking_history')),
            ],
          ),
        ),
      ],
    );
  }
}
