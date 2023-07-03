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
            ticket(size, context),
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

  ticket(Size size, context) {
    return Stack(
      children: [
        ticketDetail(size, context),
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

  ticketDetail(Size size, context) {
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
            Image.asset(
              "assets/parkingTicket/Qr Code Image.png",
              height: size.width * 0.3,
            ),
            heightSpace,
            heightSpace,
            parkingDetail(context),
            heightSpace,
            heightSpace,
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(color: Color(0xFFF0EEEE)),
              alignment: Alignment.center,
              child: Text(
                "${getTranslation(context, 'parking_ticket.payment')} : \$20(${getTranslation(context, 'parking_ticket.creditcard')})",
                style: semibold16LightBlack,
              ),
            )
          ],
        ),
      ),
    );
  }

  parkingDetail(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        children: [
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.name'),
              "Esther Howard",
              getTranslation(context, 'parking_ticket.parking_slot'),
              "1st floor(B1)"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.parking_area'),
              "Easkartoon shopping mall , new york",
              getTranslation(context, 'parking_ticket.vehicle'),
              "Toyota corolla (HJ4562Hk)"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.duration'),
              "4 hour",
              getTranslation(context, 'parking_ticket.date'),
              "April 16,2022"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_ticket.Hour'),
              "09:00 AM-13.00 PM",
              getTranslation(context, 'parking_ticket.phone'),
              "+91 1234567890"),
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
