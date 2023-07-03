import 'package:dotted_border/dotted_border.dart';
import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ExtendParkingTimeScreen extends StatefulWidget {
  const ExtendParkingTimeScreen({super.key});

  @override
  State<ExtendParkingTimeScreen> createState() =>
      _ExtendParkingTimeScreenState();
}

class _ExtendParkingTimeScreenState extends State<ExtendParkingTimeScreen> {
  var _value = 6.0;

  TextEditingController startHourController = TextEditingController();
  TextEditingController endHourController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      startHourController.text = TimeOfDay.now().format(context);
      endHourController.text =
          TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 2)))
              .format(context);
    });
    super.initState();
  }

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
          getTranslation(context, 'extend_parking_time.extend_parking_time'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
        children: [
          durationSilder(),
          heightSpace,
          startEndField(context),
          heightSpace,
          heightSpace,
          height5Space,
          divider(),
          heightSpace,
          heightSpace,
          priceWidget(
              getTranslation(context, 'extend_parking_time.price'),
              "\$5.00",
              "1 ${getTranslation(context, 'extend_parking_time.hours')}"),
          heightSpace,
          height5Space,
          priceWidget(
              getTranslation(context, 'extend_parking_time.total_price'),
              "\$20.00",
              "4 ${getTranslation(context, 'extend_parking_time.hours')}"),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          continueButton(),
        ],
      ),
    );
  }

  continueButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/paymentMethods');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [buttonShadow],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'extend_parking_time.continue'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  priceWidget(title, price, time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: bold16LightBlack,
            ),
          ),
          Row(
            children: [
              Text(price, style: bold18TextColor),
              Text("/", style: bold14LightBlack),
              Text(time, style: semibold12LightBlack)
            ],
          )
        ],
      ),
    );
  }

  divider() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      color: greyColor,
      dashPattern: const [2, 5],
      child: Container(),
    );
  }

  startEndField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          timePickerField(context, startHourController,
              getTranslation(context, 'extend_parking_time.start_hour')),
          widthSpace,
          widthSpace,
          timePickerField(context, endHourController,
              getTranslation(context, 'extend_parking_time.end_hour'))
        ],
      ),
    );
  }

  timePickerField(BuildContext context, controller, title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: bold15LightBlack,
          ),
          heightSpace,
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [boxShadow],
            ),
            child: TextField(
              style: bold14Grey,
              onTap: () async {
                final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: primaryColor)),
                          child: child!);
                    });
                if (pickedTime != null) {
                  setState(() {
                    controller.text = pickedTime.format(context);
                  });
                }
              },
              controller: controller,
              readOnly: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: fixPadding * 2.0, vertical: fixPadding * 1.4),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.access_time_rounded,
                  color: greyColor,
                  size: 19,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  durationSilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            getTranslation(context, 'extend_parking_time.duration'),
            style: bold16LightBlack,
          ),
        ),
        heightSpace,
        heightSpace,
        height5Space,
        SfSliderTheme(
          data: SfSliderThemeData(
            thumbStrokeWidth: 1.5,
            thumbStrokeColor: whiteColor,
            tooltipBackgroundColor: primaryColor,
            tooltipTextStyle: bold14LightBlack,
          ),
          child: SfSlider(
            min: 0.0,
            max: 10.0,
            enableTooltip: true,
            activeColor: primaryColor,
            inactiveColor: const Color(0xFFE6E6E6),
            tooltipTextFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return "${_value.toInt()} ${getTranslation(context, 'confirmation.hours')}";
            },
            shouldAlwaysShowTooltip: true,
            interval: 1.0,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            value: _value,
          ),
        ),
      ],
    );
  }
}
