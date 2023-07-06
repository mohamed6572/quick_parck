import 'package:dotted_border/dotted_border.dart';
import '../../localization/localization_const.dart';
import '../../theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  final bookmarkList = [
    {
      "image": "assets/myBooking/image1.png",
      "parkingName": "Smart village parking",
      "adress": "smart village , giza alex road ,cairo",
      "price": "\$5",
      "distance": 3,
      "slot": 4,
      "rate": 3.5,
    },

  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldBgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          getTranslation(context, 'bookmark.my_bookmark'),
          style: bold20LightBlack,
        ),
      ),
      body:
          bookmarkList.isEmpty ? emptyListContent() : bookmarkListContent(size),
    );
  }

  emptyListContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/bookmark/empty-bookmark.png",
            height: 35,
            width: 35,
          ),
          heightSpace,
          Text(
            getTranslation(context, 'bookmark.no_bookmark_here'),
            style: bold16Grey,
          )
        ],
      ),
    );
  }

  bookmarkListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: fixPadding),
      physics: const BouncingScrollPhysics(),
      itemCount: bookmarkList.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.14,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    bookmarkList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      duration: const Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        getTranslation(
                            context, 'bookmark.removed_from_bookmark'),
                        style: bold15White,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: fixPadding),
                  width: size.width * 0.14,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    CupertinoIcons.trash_fill,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: fixPadding),
              margin: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [buttonShadow],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Row(
                      children: [
                        Container(
                          height: size.width * 0.2,
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [boxShadow],
                            image: DecorationImage(
                              image: AssetImage(
                                bookmarkList[index]['image'].toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: const BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: textColor,
                                  size: 16,
                                ),
                                widthBox(3.0),
                                Text(
                                  bookmarkList[index]['rate'].toString(),
                                  style: semibold14LightBlack,
                                ),
                              ],
                            ),
                          ),
                        ),
                        widthSpace,
                        width5Space,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookmarkList[index]['parkingName'].toString(),
                                style: semibold18LightBlack,
                                overflow: TextOverflow.ellipsis,
                              ),
                              heightBox(3.0),
                              Text(
                                bookmarkList[index]['adress'].toString(),
                                style: semibold14Grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                              heightBox(3.0),
                              Text.rich(
                                TextSpan(
                                  text: "${bookmarkList[index]['price']}/",
                                  style: semibold16LightBlack,
                                  children: [
                                    TextSpan(
                                      text: getTranslation(
                                          context, 'bookmark.per_hour'),
                                      style: semibold15Grey,
                                    )
                                  ],
                                ),
                                style: semibold14Grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  heightSpace,
                  DottedBorder(
                    padding: EdgeInsets.zero,
                    color: greyD4Color,
                    dashPattern: const [3],
                    child: Container(),
                  ),
                  heightSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                    text:
                                        "${getTranslation(context, 'bookmark.distance_value')} : ",
                                    style: medium14LightBlack,
                                    children: [
                                      TextSpan(
                                          text:
                                              "${bookmarkList[index]['distance']} ${getTranslation(context, 'bookmark.min_walk')}",
                                          style: semibold14LightBlack)
                                    ]),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text.rich(
                                TextSpan(
                                    text:
                                        "${getTranslation(context, "bookmark.slot_available")} : ",
                                    style: medium14LightBlack,
                                    children: [
                                      TextSpan(
                                        text:
                                            "${bookmarkList[index]['slot']} ${getTranslation(context, 'bookmark.slot')}"
                                                .toString(),
                                        style: semibold14LightBlack,
                                      )
                                    ]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        width5Space,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: fixPadding,
                                horizontal: fixPadding * 1.8),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [buttonShadow],
                            ),
                            child: Text(
                              getTranslation(context, 'bookmark.book_now'),
                              style: bold16LightBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
