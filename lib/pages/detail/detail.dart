import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import '../../widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../profile/languages.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isBookMark = false;

  final facilitiesList = [
    {"image": "assets/detail/24-hours.png", "title": "24*7"},
    {"image": "assets/detail/security-camera.png", "title": "CCTV"},
    {"image": "assets/detail/payment-method.png", "title": "Payment"},
    {"image": "assets/detail/car-wash.png", "title": "Carwash"},
    {"image": "assets/detail/parking.png", "title": "Pickup"},
  ];

  final reviewList = [
    {
      "image": "assets/detail/review1.png",
      "name": "john doe",
      "date": "1 april  2020",
      "description":
          "esey way to parke",
      "rate": 4.5
    },

  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          header(size, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                heightSpace,
                heightSpace,
                parkingDetailInfo(),
                heightSpace,
                heightSpace,
                informationDetail(),
                heightSpace,
                heightSpace,
                facilityDetail(),
                heightSpace,
                rateAndReviewList(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomButtonBar(),
    );
  }

  header(Size size, BuildContext context) {
    return SliverAppBar(
      expandedHeight: size.height * 0.31,
      backgroundColor: primaryColor,
      pinned: true,
      elevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding / 1.5),
                child: Icon(
                  Icons.share_outlined,
                  color: whiteColor,
                  size: 22,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding / 1.5),
                child: Icon(
                  Icons.call_outlined,
                  color: whiteColor,
                  size: 22,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isBookMark = !isBookMark;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      duration: const Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        isBookMark
                            ? getTranslation(context, 'detail.add_bookmark')
                            : getTranslation(context, 'detail.remove_bookmark'),
                        style: bold15White,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding / 1.5),
                  child: Icon(
                    isBookMark
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/detail/image.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment:
            languageValue == 4 ? Alignment.bottomLeft : Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/images');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 1.2, vertical: fixPadding * 0.8),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: languageValue == 4
                  ? const BorderRadius.only(
                      topRight: Radius.circular(5.0),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                    ),
            ),
            child: Text(
              getTranslation(context, 'detail.more_image'),
              style: bold15LightBlack,
            ),
          ),
        ),
      )),
    );
  }

  bottomButtonBar() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(fixPadding * 2.0),
      color: scaffoldBgColor,
      child: Row(
        children: [
          Expanded(
            child: buttonWidget(
              getTranslation(context, 'detail.get_direction'),
              () {
                Navigator.pushNamed(context, '/direction');
              },
              whiteColor,
              textColor,
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: buttonWidget(
              getTranslation(context, 'detail.book_now'),
              () {
                Navigator.pushNamed(context, '/selectVehical');
              },
              primaryColor,
              lightBlackColor,
            ),
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
            horizontal: fixPadding, vertical: fixPadding * 1.4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [buttonShadow],
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

  rateAndReviewList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  getTranslation(context, 'detail.rate_review'),
                  style: bold16LightBlack,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/review');
                },
                child: Text(
                  getTranslation(context, 'detail.see_all'),
                  style: bold14Grey,
                ),
              ),
            ],
          ),
          ColumnBuilder(
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
                                vertical: fixPadding / 2,
                                horizontal: fixPadding),
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
                      )
                    ],
                  ),
                );
              },
              itemCount: reviewList.length)
        ],
      ),
    );
  }

  facilityDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            getTranslation(context, 'detail.facility_provide'),
            style: bold16LightBlack,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(fixPadding),
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              facilitiesList.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  child: Column(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        padding: const EdgeInsets.all(fixPadding),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          boxShadow: [boxShadow],
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          facilitiesList[index]['image'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      heightSpace,
                      Text(
                        facilitiesList[index]['title'].toString(),
                        style: semibold15Grey,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  informationDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslation(context, 'detail.information'),
            style: bold16LightBlack,
          ),
          heightSpace,
          Text(
            "Smart Village is in Egypt. Smart Village is situated nearby to the government office National Telecom Regulary Authority and the post office Egypt Post.",
            style: semibold14Grey,
          )
        ],
      ),
    );
  }

  parkingDetailInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Smart village parking",
                  style: semibold18LightBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Text(
                  "smart village , giza alex road ,cairo",
                  style: semibold14Grey,
                ),
                height5Space,
                Text(
                  "\$5/${getTranslation(context, 'detail.hours')}",
                  style: semibold18TextColor,
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/detail/car.png",
                    height: 22,
                    width: 22,
                  ),
                  widthSpace,
                  Text(
                    "4 ${getTranslation(context, 'detail.slot')}",
                    style: bold15LightBlack,
                  ),
                ],
              ),
              heightSpace,
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: fixPadding / 2,
                  horizontal: fixPadding,
                ),
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
                      color: textColor,
                      size: 16,
                    ),
                    widthBox(3),
                    Text(
                      "4.5",
                      style: semibold14LightBlack,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
