import '../../localization/localization_const.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List transactions = [
    {
      "title": "Leed parking spot",
      "dateTime": "20 jan, 11.20am",
      "price": "\$4.50",
      "expens": true
    },
    {
      "title": "Leed parking spot",
      "dateTime": "20 jan, 11.20am",
      "price": "\$4.50",
      "expens": true
    },
    {
      "title": "EME temple parking",
      "dateTime": "20 jan, 11.20am",
      "price": "\$4.50",
      "expens": true
    },
    {
      "title": "Add money(HDFC bank)",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": false
    },
    {
      "title": "Leed parking spot",
      "dateTime": "20 jan, 11.20am",
      "price": "\$4.50",
      "expens": true
    },
    {
      "title": "Carmant parking",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": true
    },
    {
      "title": "DFW remote parking",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": true
    },
    {
      "title": "Add money( ICICI bank)",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": false
    },
    {
      "title": "Senior parking spot",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": true
    },
    {
      "title": "Reddit  parking spot",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": true
    },
    {
      "title": "Secure car parking",
      "dateTime": "19 jan, 09.20am",
      "price": "\$25.50",
      "expens": true
    },
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
          getTranslation(context, 'wallet.wallet'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding),
        children: [
          balanceDetail(context),
          transactionListContent(),
        ],
      ),
    );
  }

  transactionListContent() {
    return ColumnBuilder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[index]['title'].toString(),
                        style: semibold16LightBlack,
                      ),
                      height5Space,
                      Text(
                        transactions[index]['dateTime'].toString(),
                        style: semibold12Grey,
                      ),
                    ],
                  ),
                ),
                Text(
                  transactions[index]['price'].toString(),
                  style: transactions[index]['expens'] == true
                      ? bold15Red
                      : bold15Green,
                )
              ],
            ),
          );
        },
        itemCount: transactions.length);
  }

  balanceDetail(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: fixPadding),
      padding: const EdgeInsets.all(fixPadding * 2.0),
      decoration: BoxDecoration(
          color: const Color(0xFFE8E6E6),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: [
          Text(
            "${getTranslation(context, 'wallet.total_amount')} : \$500",
            style: bold18LightBlack,
          ),
          heightSpace,
          heightSpace,
          Row(
            children: [
              Expanded(
                child: buttonWidget(
                  getTranslation(context, 'wallet.add_money'),
                  () {},
                  primaryColor,
                  lightBlackColor,
                ),
              ),
              widthSpace,
              widthSpace,
              Expanded(
                child: buttonWidget(
                  getTranslation(context, 'wallet.send_bank'),
                  () {},
                  whiteColor,
                  textColor,
                ),
              ),
            ],
          ),
        ],
      ),
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
}
