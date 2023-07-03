import 'dart:async';
import 'dart:ui' as ui;
import '../../localization/localization_const.dart';
import '../../pages/profile/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/key.dart';
import '../../theme/theme.dart';

class DirectionScreen extends StatefulWidget {
  const DirectionScreen({super.key});

  @override
  State<DirectionScreen> createState() => _DirectionScreenState();
}

class _DirectionScreenState extends State<DirectionScreen> {
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();

  static const CameraPosition currentPosition = CameraPosition(
    target: LatLng(51.507351, -0.127758),
    zoom: 12.00,
  );

  LatLng endLocation = const LatLng(51.532118, -0.093125);
  LatLng startLocation = const LatLng(51.475486, -0.162866);
  List<Marker> allMarkers = [];
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    getDirections();
    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      patterns: [
        PatternItem.dot,
        PatternItem.gap(3),
      ],
      polylineId: id,
      color: lightBlackColor,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          googlmap(),
          topGradient(),
          header(context),
          parkingDetail(),
        ],
      ),
    );
  }

  parkingDetail() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/arrived');
        },
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(fixPadding * 2.0),
          padding: const EdgeInsets.all(fixPadding),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.25),
                blurRadius: 8,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: const DecorationImage(
                    image: AssetImage("assets/direction/parkingImage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widthSpace,
              width5Space,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Easkartoon shopping mall",
                      style: semibold16LightBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    height5Space,
                    Text.rich(
                      TextSpan(
                        text: "3 min",
                        style: bold16TextColor,
                        children: [
                          const TextSpan(text: " "),
                          TextSpan(text: "(1.5 km)", style: bold16LightBlack)
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    height5Space,
                    Text(
                      "Open : 24 hr",
                      style: semibold14Grey,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 3.5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
          ),
          Expanded(
            child: Container(
              margin: languageValue == 4
                  ? const EdgeInsets.only(left: fixPadding * 2.0)
                  : const EdgeInsets.only(right: fixPadding * 2.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: [boxShadow],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                        const ColorScheme.light(primary: primaryColor)),
                child: TextField(
                  style: bold16LightBlack,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: fixPadding * 1.2,
                        horizontal: fixPadding * 1.2),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    hintText: getTranslation(context, 'direction.search'),
                    hintStyle: bold15Grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  topGradient() {
    return Container(
      height: 120,
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

  googlmap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.terrain,
      initialCameraPosition: currentPosition,
      onMapCreated: mapCreated,
      markers: Set.from(allMarkers),
      polylines: Set<Polyline>.of(polylines.values),
    );
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

  mapCreated(GoogleMapController controller) async {
    mapController = controller;
    await marker();
    setState(() {});
  }

  marker() async {
    allMarkers.add(
      Marker(
        markerId: const MarkerId("drop location"),
        position: endLocation,
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/home/parkingMarker.png", 90),
        ),
      ),
    );
    allMarkers.add(
      Marker(
        markerId: const MarkerId("your location"),
        position: startLocation,
        anchor: const Offset(0.3, 0.5),
        icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset("assets/direction/car.png", 220),
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
