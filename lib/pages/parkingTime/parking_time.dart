import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import '../../theme/theme.dart';

class ParkingTimeScreen extends StatefulWidget {
  const ParkingTimeScreen({super.key});

  @override
  State<ParkingTimeScreen> createState() => _ParkingTimeScreenState();
}

class _ParkingTimeScreenState extends State<ParkingTimeScreen>
    with SingleTickerProviderStateMixin {
  final CountDownController controller = CountDownController();

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
          getTranslation(context, 'parking_time.parking_time'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          timer(),
          heightSpace,
          heightSpace,
          height5Space,
          parkingDetail(),
          heightSpace,
          heightSpace,
          heightSpace,
          height5Space,
          extendButton(),
        ],
      ),
    );
  }

  extendButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/extendParkingTime')
            .then((value) => controller.resume());
        controller.pause();
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
          getTranslation(context, 'parking_time.extend_parking_time'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  parkingDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [boxShadow],
      ),
      child: Column(
        children: [
          parkingDetailRow(
              getTranslation(context, 'parking_time.name'),
              "Esther Howard",
              getTranslation(context, 'parking_time.parking_slot'),
              "1st floor(B1)"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_time.parking_area'),
              "Easkartoon shopping mall , new york",
              getTranslation(context, 'parking_time.vehicle'),
              "Toyota corolla (HJ4562Hk)"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_time.duration'),
              "4 hour",
              getTranslation(context, 'parking_time.date'),
              "April 16,2022"),
          heightSpace,
          heightSpace,
          parkingDetailRow(
              getTranslation(context, 'parking_time.hour'),
              "09:00 AM-13.00 PM",
              getTranslation(context, 'parking_time.phone'),
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
        width5Space,
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

  timer() {
    return Center(
      child: SizedBox(
        height: 180,
        width: 180,
        child: NeonCircularTimer(
          onComplete: () {},
          width: 200,
          controller: controller,
          duration: 1800,
          strokeWidth: 10,
          isTimerTextShown: true,
          neumorphicEffect: true,
          initialDuration: 0,
          textFormat: TextFormat.HH_MM_SS,
          textStyle: semibold30Black,
          outerStrokeColor: scaffoldBgColor,
          innerFillGradient:
              const LinearGradient(colors: [primaryColor, primaryColor]),
          strokeCap: StrokeCap.round,
          innerFillColor: const Color(0xFFE9E7E7),
          backgroudColor: const Color(0xFFE9E7E7),
        ),
      ),
    );
  }
}
