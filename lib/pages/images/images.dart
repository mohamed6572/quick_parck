import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final images = [
    "assets/image/image1.png",
    "assets/image/image2.png",
    "assets/image/image3.png",
  ];

  PageController pageController = PageController(viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagesList(size),
            heightSpace,
            heightSpace,
            imagesLength()
          ],
        ),
      ),
    );
  }

  imagesLength() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (selectedIndex > 0) {
              pageController.animateToPage(selectedIndex - 1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
        ),
        Text(
          (selectedIndex + 1).toString(),
          style: semibold20Black,
        ),
        IconButton(
          onPressed: () {
            if (selectedIndex < images.length - 1) {
              pageController.animateToPage(selectedIndex + 1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            }
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 22,
          ),
        ),
      ],
    );
  }

  imagesList(Size size) {
    return SizedBox(
      height: size.height * 0.7,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        controller: pageController,
        children: List.generate(
          images.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(
                  images[index],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
