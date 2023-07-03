import 'dart:async';
import 'dart:ui' as ui;
import 'package:dotted_border/dotted_border.dart';
import '../../constants/user_data.dart';
import '../../localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _value = 60.0;
  var _value2 = 100.0;
  int selectedrate = 5;
  GoogleMapController? mapController;

  final parkingList = [
    {
      "image": "assets/home/parking1.png",
      "parkingName": "Smart village parking",
      "adress": "smart village , giza alex road ,cairo",
      "price": "\$5",
      "distance": 3,
      "slot": 4,
      "rate": 4.5,
      "latLang": const LatLng(30.07667, 31.01889),
      "id": "11"
    },

  ];

  List parkingMarkerList = [
    const LatLng(30.07667, 31.01889),
    const LatLng(30.07667, 31.01889),
    const LatLng(30.07667, 31.01889),
    const LatLng(30.07667, 31.01889),
    const LatLng(30.07667, 31.01889),
    const LatLng(30.07667, 31.01889),
  ];

  List<Marker> allMarkers = [];

  PageController pageController =
      PageController(viewportFraction: 0.9, initialPage: 1);
  double _currPageValue = 1.0;
  double scaleFactor = .8;
  double height = 150;

  static const CameraPosition _currentPosition =
      CameraPosition(target: LatLng(30.07667, 31.01889), zoom: 12);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  marker() async {
    allMarkers.add(
      Marker(
        markerId: const MarkerId("your location"),
        position: const LatLng(30.07667, 31.01889),
        infoWindow: const InfoWindow(title: "You are here"),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/home/car.png", 270),
        ),
      ),
    );

    for (int i = 0; i < parkingList.length; i++) {
      allMarkers.add(Marker(
        markerId: MarkerId(parkingList[i]['id'].toString()),
        position: parkingList[i]['latLang'] as LatLng,
        infoWindow: InfoWindow(title: parkingList[i]['parkingName'].toString()),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/home/parkingMarker.png", 80),
        ),
      ));
    }

    for (int i = 0; i < parkingMarkerList.length; i++) {
      allMarkers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: parkingMarkerList[i],
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/home/parkingMarker.png", 80),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          googleMap(size),
          parkingListContent(size),
          topGradient(),
          userInfo(context, size)
        ],
      ),
    );
  }

  userInfo(BuildContext context, size) {
    return Padding(
      padding: const EdgeInsets.only(
          left: fixPadding * 2.0,
          right: fixPadding * 2.0,
          top: fixPadding * 3.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('$image'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$Name",
                      style: bold18LightBlack,
                    ),
                    Text(
                      getTranslation(context, 'extend_parking_time.find'),
                      style: semibold14Grey.copyWith(
                        color: const Color(0xFF8E8E8E),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/notification');
                },
                child: Container(
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/home/notification.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              )
            ],
          ),
          heightSpace,
          height5Space,
          searchField(context, size),
        ],
      ),
    );
  }

  searchField(BuildContext context, Size size) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor)),
        child: TextField(
          style: bold16LightBlack,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: fixPadding, horizontal: fixPadding * 1.2),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  filterBottomSheet(size, context);
                },
                icon: const Icon(
                  Icons.filter_list_outlined,
                  color: lightBlackColor,
                ),
              ),
              hintText: getTranslation(context, 'extend_parking_time.search'),
              hintStyle: bold15Grey),
        ),
      ),
    );
  }

  filterBottomSheet(ui.Size size, BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: size.height - 80,
      ),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: fixPadding * 2.0),
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Container(
                      height: 2,
                      width: 60,
                      decoration: const BoxDecoration(
                        color: greyD9Color,
                      ),
                    ),
                    heightSpace,
                    height5Space,
                    Text(
                      getTranslation(context, 'extend_parking_time.filter'),
                      style: bold18TextColor,
                    ),
                    heightSpace,
                    height5Space,
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: greyD4Color,
                    )
                  ],
                ),
                heightSpace,
                heightSpace,
                distanceSilder(state),
                heightSpace,
                heightSpace,
                priceSilder(state),
                heightSpace,
                heightSpace,
                rating(state),
                heightSpace,
                heightSpace,
                heightSpace,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: buttonWidget(
                          getTranslation(
                              context, 'extend_parking_time.clear_all'),
                          () {
                            setState(() {
                              _value = 60.0;
                              _value2 = 100.0;
                              selectedrate = 5;
                            });
                            Navigator.pop(context);
                          },
                          whiteColor,
                          textColor,
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: buttonWidget(
                          getTranslation(context, 'extend_parking_time.apply'),
                          () {
                            Navigator.pop(context);
                          },
                          primaryColor,
                          lightBlackColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
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
          boxShadow: [boxShadow],
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: bold18TextColor.copyWith(color: textColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  rating(StateSetter state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslation(context, 'extend_parking_time.rating'),
            style: bold16LightBlack,
          ),
          heightSpace,
          height5Space,
          Wrap(
            spacing: fixPadding,
            runSpacing: fixPadding,
            children: [
              for (int i = 5; i >= 1; i--)
                GestureDetector(
                  onTap: () {
                    state(() {
                      setState(() {
                        selectedrate = i;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0, vertical: fixPadding / 2),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: selectedrate == i
                            ? primaryColor
                            : const Color(0xFFE6E6E6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          i.toString(),
                          style:
                              selectedrate == i ? bold14TextColor : bold14Grey,
                        ),
                        widthBox(2),
                        Icon(
                          Icons.star,
                          size: 15,
                          color: selectedrate == i ? textColor : greyColor,
                        )
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  distanceSilder(StateSetter state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            getTranslation(context, 'extend_parking_time.distance'),
            style: bold16LightBlack,
          ),
        ),
        heightSpace,
        heightSpace,
        SfSliderTheme(
          data: SfSliderThemeData(
            thumbStrokeWidth: 1.5,
            thumbStrokeColor: whiteColor,
            tooltipBackgroundColor: primaryColor,
            tooltipTextStyle: bold14LightBlack,
          ),
          child: SfSlider(
            min: 0.0,
            max: 150.0,
            enableTooltip: true,
            activeColor: primaryColor,
            inactiveColor: const Color(0xFFE6E6E6),
            tooltipTextFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return "${_value.toStringAsFixed(1)} km";
            },
            shouldAlwaysShowTooltip: true,
            interval: 1.0,
            onChanged: (value) {
              state(() {
                setState(() {
                  _value = value;
                });
              });
            },
            value: _value,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0.00km",
                style: bold14Grey,
              ),
              Text(
                "150km",
                style: bold14Grey,
              )
            ],
          ),
        ),
      ],
    );
  }

  priceSilder(StateSetter state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            getTranslation(context, 'extend_parking_time.price'),
            style: bold16LightBlack,
          ),
        ),
        heightSpace,
        heightSpace,
        SfSliderTheme(
          data: SfSliderThemeData(
            thumbStrokeWidth: 1.5,
            thumbStrokeColor: whiteColor,
            tooltipBackgroundColor: primaryColor,
            tooltipTextStyle: bold14LightBlack,
          ),
          child: SfSlider(
            min: 2.0,
            max: 200.0,
            enableTooltip: true,
            activeColor: primaryColor,
            inactiveColor: const Color(0xFFE6E6E6),
            tooltipTextFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return "\$${_value2.toInt()}";
            },
            shouldAlwaysShowTooltip: true,
            interval: 1.0,
            onChanged: (value) {
              state(() {
                setState(() {
                  _value2 = value;
                });
              });
            },
            value: _value2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$2.00/${getTranslation(context, 'extend_parking_time.per_hour')}",
                style: bold14Grey,
              ),
              Text(
                "\$200.00/${getTranslation(context, 'extend_parking_time.per_hour')}",
                style: bold14Grey,
              )
            ],
          ),
        )
      ],
    );
  }

  topGradient() {
    return Container(
      height: 125,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.6, 1.0],
          colors: [
            const Color(0xFFF4F4F4).withOpacity(0.8),
            const Color(0xFFB4B4B4).withOpacity(0)
          ],
        ),
      ),
    );
  }

  Future<void> _goCurrentPosition() async {
    final GoogleMapController controller = mapController!;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_currentPosition),
    );
  }

  parkingListContent(Size size) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: fixPadding * 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding),
            child: FloatingActionButton(
              onPressed: () {
                _goCurrentPosition();
              },
              mini: true,
              backgroundColor: const Color(0xFF494747),
              child: const Icon(
                Icons.my_location_sharp,
                color: whiteColor,
                size: 22,
              ),
            ),
          ),
          SizedBox(
            height: 180.0,
            width: size.width,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                moveCamera(parkingList[index]['latLang'] as LatLng);
              },
              controller: pageController,
              itemCount: parkingList.length,
              itemBuilder: (context, index) {
                return _buildListContent(index, size);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildListContent(int index, Size size) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, currTrans, 0.0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0.0, height * (1 - scaleFactor) / 2, 0.0);
    }
    return GestureDetector(
      onTap: () {},
      child: Transform(
        transform: matrix,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: fixPadding),
            margin: const EdgeInsets.symmetric(horizontal: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [buttonShadow],
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
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
                              parkingList[index]['image'].toString(),
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
                                parkingList[index]['rate'].toString(),
                                style: semibold14LightBlack,
                              )
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
                              parkingList[index]['parkingName'].toString(),
                              style: semibold18LightBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(3.0),
                            Text(
                              parkingList[index]['adress'].toString(),
                              style: semibold14Grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(3.0),
                            Text.rich(
                              TextSpan(
                                text: "${parkingList[index]['price']}/",
                                style: semibold16LightBlack,
                                children: [
                                  TextSpan(
                                    text: getTranslation(context,
                                        'extend_parking_time.per_hour'),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                  text:
                                      "${getTranslation(context, 'extend_parking_time.distance_value')} : ",
                                  style: medium14LightBlack,
                                  children: [
                                    TextSpan(
                                        text:
                                            "${parkingList[index]['distance']} ${getTranslation(context, 'extend_parking_time.min_walk')}",
                                        style: semibold14LightBlack)
                                  ]),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text.rich(
                              TextSpan(
                                  text:
                                      "${getTranslation(context, 'extend_parking_time.slot_available')} : ",
                                  style: medium14LightBlack,
                                  children: [
                                    TextSpan(
                                      text:
                                          "${parkingList[index]['slot']} ${getTranslation(context, 'extend_parking_time.slot')}"
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
                              horizontal: fixPadding * 1.7),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [buttonShadow],
                          ),
                          child: Text(
                            getTranslation(
                                context, 'extend_parking_time.book_now'),
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
      ),
    );
  }

  googleMap(size) {
    return SizedBox(
      height: double.maxFinite,
      width: size.width,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _currentPosition,
        markers: Set.from(allMarkers),
        onMapCreated: mapCreated,
        zoomControlsEnabled: false,
      ),
    );
  }

  mapCreated(GoogleMapController controller) async {
    mapController = controller;
    await marker();
    if (mounted) {
      setState(() {});
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  moveCamera(LatLng target) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          bearing: 45.0,
          zoom: 14.0,
          tilt: 45.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }
}
