import 'package:dotted_border/dotted_border.dart';
import '../../constants/user_data.dart';
import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../theme/theme.dart';

class BookParkingDetailScreen extends StatefulWidget {
  const BookParkingDetailScreen({super.key});

  @override
  State<BookParkingDetailScreen> createState() =>
      _BookParkingDetailScreenState();
}

class _BookParkingDetailScreenState extends State<BookParkingDetailScreen> {
  DateTime selectedDate = DateTime.now();

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
    getSlots();
  }

  var _value = 6.0;

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
          getTranslation(context, 'book_parking_detail.book_parking_detail'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          selectDateTitle(),
          heightSpace,
          calendar(context),
          heightSpace,
          heightSpace,
          divider(),
          heightSpace,
          heightSpace,
          durationSilder(),
          heightSpace,
          startEndField(context),
          heightSpace,
          heightSpace,
          divider(),
          heightSpace,
          heightSpace,
          priceWidget(
              getTranslation(context, 'book_parking_detail.price'),
              "\$5.00",
              "1 ${getTranslation(context, 'book_parking_detail.hours')}"),
          heightSpace,
          height5Space,
          priceWidget(
              getTranslation(context, 'book_parking_detail.total_price'),
              "\$ ${_value.toInt()*5}",
              "${_value.toInt()} ${getTranslation(context, 'book_parking_detail.hours')}"),
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
        print(startHourController.text);
        print(endHourController.text);
        print(_value.toInt()*5);
        print('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');

        price= _value.toInt()*5 ;
        start_time= startHourController.text ;
        end_time=endHourController.text  ;
        duration= "${_value.toInt()}" ;
        date=  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
print(price);
print(start_time);
print(end_time);
print(duration);
print(date);
        Navigator.pushNamed(context, '/selectSlot');
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
          getTranslation(context, 'book_parking_detail.continue'),
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

  startEndField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          timePickerField(context, startHourController,
              getTranslation(context, 'book_parking_detail.start_hour')),
          widthSpace,
          widthSpace,
          timePickerField(context, endHourController,
              getTranslation(context, 'book_parking_detail.end_hour'))
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
              style: bold14Grey,
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
            getTranslation(context, 'book_parking_detail.duration'),
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
                print(_value.toInt());
              });
            },
            value: _value,
          ),
        ),
      ],
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

  selectDateTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Text(
        getTranslation(context, 'book_parking_detail.select_date'),
        style: bold16LightBlack,
      ),
    );
  }

  calendar(BuildContext context) {
    return Container(
      height: 258,
      width: double.maxFinite,
      padding: const EdgeInsets.only(bottom: fixPadding),
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: whiteColor,
        boxShadow: [boxShadow],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
            onPrimary: blackColor,
            onSurface: Color(0xFF4A5660),
          ),
        ),
        child: CalendarDatePicker(
          currentDate: selectedDate,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 3650)),
          onDateChanged: (date) {
            setState(() {
              selectedDate = date;
              /// to take date from UI
              print('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
            });
          },
        ),
      ),
    );
  }
}
