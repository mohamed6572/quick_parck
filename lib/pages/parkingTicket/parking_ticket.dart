import '../../constants/user_data.dart';
import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ParkingTicketScreen extends StatelessWidget {
  const ParkingTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routedata =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    var data = routedata['id'];
int index = data;
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => onWillPop(context, data),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: scaffoldBgColor,
          titleSpacing: data == 1 ? 20.0 : 0.0,
          shadowColor: shadowColor.withOpacity(0.25),
          foregroundColor: lightBlackColor,
          automaticallyImplyLeading: false,
          leading: data == 1
              ? null
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print(data);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
          title: Text(
            getTranslation(context, 'parking_ticket.parking_ticket'),
            style: bold18LightBlack,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          physics: const BouncingScrollPhysics(),
          children: [
            ticket(size, context,index),
            heightSpace,
            heightSpace,
            data == 0
                ? const SizedBox()
                : Column(
                    children: [
                      getDirection(context),
                      heightSpace,
                      heightSpace,
                      data == 2 ? const SizedBox() : notNowButton(context)
                    ],
                  )
          ],
        ),
      ),
    );
  }

  notNowButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/bottomBar');
        },
        child: Text(
          getTranslation(context, 'parking_ticket.not_now'),
          style: bold18TextColor,
        ),
      ),
    );
  }

  getDirection(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/direction');
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
          getTranslation(context, 'parking_ticket.get_direction'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  ticket(Size size, context,index) {
    return Stack(
      children: [
        ticketDetail(size, context,index),
        Positioned(
          left: -20,
          right: -20,
          top: size.height * 0.27,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: scaffoldBgColor,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: scaffoldBgColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ticketDetail(Size size, context,index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [boxShadow],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding * 2.0),
              child: Text(
                getTranslation(context, 'parking_ticket.scan_text'),
                style: semibold16LightBlack,
                textAlign: TextAlign.center,
              ),
            ),
            height5Space,

            heightSpace,
            heightSpace,
            parkingDetail(context,index),
            heightSpace,
            heightSpace,
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(color: Color(0xFFF0EEEE)),
              alignment: Alignment.center,
              child: Text(
                "${getTranslation(context, 'parking_ticket.payment')} : \$${ongoingList![index]['total_price']}(${getTranslation(context, 'parking_ticket.creditcard')})",
                style: semibold16LightBlack,
              ),
            )
          ],
        ),
      ),
    );
  }

  parkingDetail(context,index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        children: [
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.name'),
              "${ongoingList![index]['name']}",
              getTranslation(context, 'parking_ticket.parking_slot'),
              "${ongoingList![index]['slot']}"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.parking_area'),
              "${ongoingList![index]['description']}",
              getTranslation(context, 'parking_ticket.vehicle'),
              "Toyota corolla (HJ4562Hk)"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.duration'),
              "${ongoingList![index]['duration']} hour",
              getTranslation(context, 'parking_ticket.date'),
              "${ongoingList![index]['date']}"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.Hour'),
              "${ongoingList![index]['start_time']}-${ongoingList![index]['end_time']}",
              getTranslation(context, 'parking_ticket.phone'),
              "$phone"),
        ],
      ),
    );
  }

  parkingDetailRow(title1, detail1, title2, detail2) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title1,
                style: semibold14Grey,
              ),
              Text(
                detail1,
                style: semibold15LightBlack,
              )
            ],
          ),
        ),
        widthSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style: semibold14Grey,
              ),
              Text(
                detail2,
                style: semibold15LightBlack,
              )
            ],
          ),
        )
      ],
    );
  }

  onWillPop(context, data) {
    data == 2
        ? Navigator.pop(context)
        : Navigator.pushNamed(context, '/bottomBar');
  }
}
