import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final reviewList = [
    {
      "image": "assets/review/review1.png",
      "name": "Esther Howard",
      "date": "1 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 4.5
    },
    {
      "image": "assets/review/review2.png",
      "name": "Esther Howard",
      "date": "2 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 3.5
    },
    {
      "image": "assets/review/review6.png",
      "name": "Jane Cooper",
      "date": "4 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 3.0
    },
    {
      "image": "assets/review/review5.png",
      "name": "Ronald Richards",
      "date": "5 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 4.0
    },
    {
      "image": "assets/review/review4.png",
      "name": "12 april  2020",
      "date": "5 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 5.0
    },
    {
      "image": "assets/review/review3.png",
      "name": "Devon Lane",
      "date": "12 april  2020",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit Amet minim mollit non",
      "rate": 3.0
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
          getTranslation(context, 'review.review'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
              vertical: fixPadding, horizontal: fixPadding * 2.0),
          itemCount: reviewList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: fixPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              reviewList[index]['image'].toString(),
                            ),
                          ),
                        ),
                      ),
                      widthSpace,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewList[index]['name'].toString(),
                            style: regular16LightBlack,
                          ),
                          height5Space,
                          Text(
                            reviewList[index]['date'].toString(),
                            style: semibold14Grey,
                          )
                        ],
                      )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding / 2, horizontal: fixPadding),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor.withOpacity(0.1),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: textColor,
                            ),
                            widthBox(3),
                            Text(
                              reviewList[index]['rate'].toString(),
                              style: semibold14LightBlack,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  heightSpace,
                  Text(
                    reviewList[index]['description'].toString(),
                    style: medium14Grey,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
