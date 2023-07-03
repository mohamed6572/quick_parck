import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../theme/theme.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSave = true;

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
          getTranslation(context, 'credit_card.credit_card'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding / 2),
        physics: const BouncingScrollPhysics(),
        children: [
          creditCard(size),
          heightSpace,
          enterTitle(),
          creditcardfrom(),
          height5Space,
          saveCard(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          paymentButton(),
          heightSpace,
          height5Space,
        ],
      ),
    );
  }

  paymentButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/bookingConfirm');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 1.8),
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [buttonShadow],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'credit_card.payment'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  enterTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
      child: Text(
        getTranslation(context, 'credit_card.enter_card_details'),
        style: semibold16LightBlack,
      ),
    );
  }

  saveCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.8),
      child: InkWell(
        onTap: () {
          setState(() {
            isSave = !isSave;
          });
        },
        child: Row(
          children: [
            isSave
                ? Container(
                    height: 18,
                    width: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.done,
                      size: 13,
                      color: blackColor,
                    ),
                  )
                : Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor),
                    ),
                  ),
            width5Space,
            Text(
              getTranslation(context, 'credit_card.save_this_card'),
              style: semibold14Grey,
            )
          ],
        ),
      ),
    );
  }

  creditCard(Size size) {
    return CreditCardWidget(
      height: size.height * 0.28,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: true,
      obscureCardCvv: true,
      isHolderNameVisible: true,
      cardType: CardType.visa,
      isChipVisible: false,
      padding: fixPadding * 1.5,
      cardBgColor: scaffoldBgColor,
      bankName: "Credit card",
      backgroundImage: "assets/creditCard/credit-card.png",
      customCardTypeIcons: <CustomCardTypeIcon>[
        CustomCardTypeIcon(
          cardType: CardType.visa,
          cardImage: Image.asset(
            'assets/creditCard/visa-pay-logo.png',
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ],
      onCreditCardWidgetChange: (CreditCardBrand? creditCardBrand) {},
    );
  }

  creditcardfrom() {
    return CreditCardForm(
      obscureCvv: true,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      cursorColor: primaryColor,
      cardHolderDecoration: InputDecoration(
        hintText: getTranslation(context, 'credit_card.enter_card_name'),
        hintStyle: semibold15Grey,
        labelText: getTranslation(context, 'credit_card.name_card'),
        labelStyle: semibold20Grey,
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      cardNumberDecoration: InputDecoration(
        hintText: getTranslation(context, 'credit_card.enter_card_number'),
        hintStyle: semibold15Grey,
        labelText: getTranslation(context, 'credit_card.card_number'),
        labelStyle: semibold20Grey,
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      expiryDateDecoration: InputDecoration(
        hintText: getTranslation(context, 'credit_card.expire_date'),
        hintStyle: semibold15Grey,
        labelText: getTranslation(context, 'credit_card.expire_date'),
        labelStyle: semibold20Grey,
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      cvvCodeDecoration: InputDecoration(
        hintText: getTranslation(context, 'credit_card.CVV'),
        hintStyle: semibold15Grey,
        labelText: "CVV",
        labelStyle: semibold20Grey,
        filled: true,
        fillColor: whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: shadowColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      onCreditCardModelChange: (CreditCardModel? creditCardModel) {
        setState(() {
          cardNumber = creditCardModel!.cardNumber;
          expiryDate = creditCardModel.expiryDate;
          cardHolderName = creditCardModel.cardHolderName;
          cvvCode = creditCardModel.cvvCode;
          isCvvFocused = creditCardModel.isCvvFocused;
        });
      },
      themeColor: primaryColor,
      formKey: formKey,
    );
  }
}
