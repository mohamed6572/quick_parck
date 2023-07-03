import 'package:dotted_border/dotted_border.dart';
import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({super.key});

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
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
          getTranslation(context, 'confirmation.booking_confirmation'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          parkingDetail(),
          heightSpace,
          heightSpace,
          bookingDetail(),
          heightSpace,
          heightSpace,
          paymentDetail(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          height5Space,
          confirmPayment(size),
        ],
      ),
    );
  }

  confirmPayment(Size size) {
    return GestureDetector(
      onTap: () {
        successDialog(size);
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
          getTranslation(context, 'confirmation.confirm_payment'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  successDialog(Size size) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 3.0, vertical: fixPadding * 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: whiteColor,
            child: Container(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image.asset(
                    "assets/arrived/success.png",
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                  ),
                  heightSpace,
                  heightSpace,
                  Text(
                    getTranslation(context, 'confirmation.successful'),
                    style: bold22LightBlack,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  Text(
                    getTranslation(context, 'confirmation.successful_text'),
                    style: semibold16Grey,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/parkingTicket',
                              arguments: {"id": 1})
                          .then((value) => Navigator.pop(context));
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(fixPadding * 1.4),
                      margin:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
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
                        getTranslation(
                            context, 'confirmation.view_parking_ticket'),
                        style: bold18TextColor,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  heightSpace,
                  heightSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/bottomBar');
                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(fixPadding * 1.4),
                      margin:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [buttonShadow],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        getTranslation(context, 'confirmation.back_home'),
                        style: bold18LightBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  paymentDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 1.5, vertical: fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/payment/credit-card.png",
            height: 28,
          ),
          widthSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslation(context, 'confirmation.credit_card'),
                style: bold16LightBlack,
              ),
              height5Space,
              Text(
                "XXXX  XXXX  XXXX 1254",
                style: medium14Grey,
              )
            ],
          )
        ],
      ),
    );
  }

  bookingDetail() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.25),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          bookingWidget(
              getTranslation(context, 'confirmation.date'), "April 16,2022"),
          bookingWidget(
              getTranslation(context, 'confirmation.duration'), "4 hour"),
          bookingWidget(getTranslation(context, 'confirmation.vehicle'),
              "Toyota corolla(HJ4562Hk)"),
          bookingWidget(getTranslation(context, 'confirmation.hours'),
              "09:00 AM-13.00 PM"),
          bookingWidget(getTranslation(context, 'confirmation.parking_slot'),
              "1st floor B1"),
          height5Space,
          divider(),
          height5Space,
          bookingWidget(getTranslation(context, 'confirmation.price'), "\$5"),
          bookingWidget(getTranslation(context, 'confirmation.tax'), "\$0"),
          bookingWidget(
              "${getTranslation(context, 'confirmation.total_price')}(4 ${getTranslation(context, 'confirmation.hour')})",
              "\$20"),
        ],
      ),
    );
  }

  divider() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      dashPattern: const [2, 5],
      color: greyColor,
      child: Container(),
    );
  }

  bookingWidget(title, detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 0.6),
      child: Row(
        children: [
          Expanded(
            child:
                Text(title, style: bold14Grey, overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            child: Text(detail,
                style: bold15LightBlack,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }

  parkingDetail() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 83,
            width: 83,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: const DecorationImage(
                image: AssetImage("assets/direction/parkingImage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          width5Space,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Easkartoon shopping mall",
                  style: bold16LightBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Text(
                  "1024 Botanic garden road,new york",
                  style: semibold14Grey,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Text(
                  "\$5/${getTranslation(context, 'confirmation.Hours')}",
                  style: semibold18TextColor,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
