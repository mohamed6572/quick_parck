import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List todayList = [
    {
      "title": "Payment successful",
      "description": "Your payment \$50 successfully paid",
      "time": "10.30am",
      "type": "Payment Success"
    },
    {
      "title": "Parking booking canceled",
      "description": "Your DCM parking booking payment failed.",
      "time": "11.30am",
      "type": "Booking Cancel"
    },
  ];

  final List yesterdayList = [
    {
      "title": "Parking booking success",
      "description": "Your payment \$50 successfully paid",
      "time": "09.30am",
      "type": "Parking Booking"
    },
    {
      "title": "Payment successful",
      "description": "Your payment \$50 successfully paid",
      "time": "11.30am",
      "type": "Payment Success"
    },
    {
      "title": "Parking booking success",
      "description": "Your payment \$50 successfully paid",
      "time": "10.00am",
      "type": "Parking Booking"
    },
    {
      "title": "Parking booking canceled",
      "description": "Your DCM parking booking payment failed.",
      "time": "10.30am",
      "type": "Booking Cancel"
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
          getTranslation(context, 'notification.notification'),
          style: bold18LightBlack,
        ),
      ),
      body: (todayList.isEmpty && yesterdayList.isEmpty)
          ? emptyListContent(context)
          : notificationListContent(),
    );
  }

  emptyListContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/notification/no_notificationn.png",
            height: 40,
            width: 40,
            color: greyColor,
          ),
          heightSpace,
          height5Space,
          Text(
            getTranslation(context, 'notification.no_notification'),
            style: bold16Grey,
          )
        ],
      ),
    );
  }

  notificationListContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
      physics: const BouncingScrollPhysics(),
      children: [
        todayList.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Text(
                      getTranslation(context, 'notification.today'),
                      style: bold16LightBlack,
                    ),
                  ),
                  height5Space,
                  ColumnBuilder(
                    itemBuilder: (context, index) {
                      return listContent(index, todayList);
                    },
                    itemCount: todayList.length,
                  ),
                  heightSpace,
                ],
              ),
        yesterdayList.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Text(
                      getTranslation(context, 'notification.yesterday'),
                      style: bold16LightBlack,
                    ),
                  ),
                  height5Space,
                  ColumnBuilder(
                    itemBuilder: (context, index) {
                      return listContent(index, yesterdayList);
                    },
                    itemCount: yesterdayList.length,
                  )
                ],
              ),
      ],
    );
  }

  listContent(int index, List listname) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          listname.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: blackColor,
            duration: const Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating,
            content: Text(
              getTranslation(context, 'notification.removed_notification'),
              style: bold15White,
            ),
          ),
        );
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
        color: redColor,
      ),
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 6.0, horizontal: fixPadding),
        margin: const EdgeInsets.symmetric(
            vertical: fixPadding, horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [boxShadow],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            if (listname[index]['type'] == "Payment Success")
              paymentSuccessIcon(),
            if (listname[index]['type'] == "Booking Cancel")
              bookingCancelIcon(),
            if (listname[index]['type'] == "Parking Booking")
              parkingBookingIcon(),
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listname[index]['title'],
                    style: bold16LightBlack,
                  ),
                  height5Space,
                  Text(
                    listname[index]['description'],
                    style: bold14Grey,
                  ),
                  height5Space,
                  Text(
                    listname[index]['time'],
                    style: bold12Grey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  paymentSuccessIcon() {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.all(fixPadding / 2),
      decoration: const BoxDecoration(
        color: Color(0xFFB7EBB2),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF71BD6A),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.done,
          color: whiteColor,
          size: 22,
        ),
      ),
    );
  }

  parkingBookingIcon() {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.all(fixPadding / 2),
      decoration: const BoxDecoration(
        color: Color(0xFFF4E5CF),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: textColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.local_parking,
          color: whiteColor,
          size: 22,
        ),
      ),
    );
  }

  bookingCancelIcon() {
    return Container(
      height: 47,
      width: 47,
      padding: const EdgeInsets.all(fixPadding / 2),
      decoration: const BoxDecoration(
        color: Color(0xFFFFDFE5),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEF8989),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: whiteColor,
          size: 22,
        ),
      ),
    );
  }
}
