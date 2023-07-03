import '../../localization/localization_const.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final paymentList = [
    {"image": "assets/payment/credit-card.png", "name": "Credit card"},
    {"image": "assets/payment/paypal.png", "name": "Paypal"},
    {"image": "assets/payment/google-pay.png", "name": "Google pay"},
    {"image": "assets/payment/wallet.png", "name": "Use wallet"},
    {"image": "assets/payment/paySpot.png", "name": "Pay on spot"},
  ];

  int selectedIndex = 0;

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
          getTranslation(context, 'payment_method.payment_method'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          paymentListContent(),
          heightSpace,
          heightSpace,
          height5Space,
          totalPaymentText(),
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
        Navigator.pushNamed(context, '/creditCard');
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
          getTranslation(context, 'payment_method.continue'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  totalPaymentText() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: getTranslation(context, 'payment_method.total_payment'),
        style: semibold16LightBlack,
        children: [
          const TextSpan(text: " : "),
          TextSpan(text: "\$20.00", style: bold18LightBlack)
        ],
      ),
    );
  }

  paymentListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              leading: SizedBox(
                width: 50,
                child: Image.asset(
                  paymentList[index]['image'].toString(),
                  height: 28,
                ),
              ),
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2.0, vertical: fixPadding / 2),
              title: Text(
                paymentList[index]['name'].toString(),
                style: semibold16LightBlack,
              ),
              trailing: selectedIndex == index
                  ? Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.done,
                        color: lightBlackColor,
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
            ),
            paymentList.length == index + 1
                ? const SizedBox()
                : Container(
                    height: 1,
                    width: double.maxFinite,
                    color: greyD4Color,
                  ),
          ],
        );
      },
      itemCount: paymentList.length,
    );
  }
}
