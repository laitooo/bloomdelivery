import 'dart:async';

import 'package:bloomdeliveyapp/services/google_map/google_map_service.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/ui/theme/theme_provider.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/bottom_sheet_navigator.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_builder.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_controller.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/search_places_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

final scaffoldKey2 = new GlobalKey<ScaffoldState>();

class DeliveryMapScreen extends StatefulWidget {
  final mapController = MapController();

  DeliveryMapScreen({Key? key}) : super(key: key);

  @override
  DeliveryMapScreenState createState() => DeliveryMapScreenState();
}

class DeliveryMapScreenState extends State<DeliveryMapScreen> {
  final bottomSheetNavigatorKey = GlobalKey<BottomSheetNavigatorState>();
  final googleMapsService = serviceLocator<GoogleMapsServices>();

  final Set<Polyline> polylines = {};
  final Set<Marker> markers = {};
  final showMidScreenPointer = true;

  void _showLocationServiceDialog() {
    // TODO: implement this
  }

  void _showLocationPermissionDialog() {
    // TODO: implement this
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      body: Stack(
        children: [
          MapBuilder(
              create: (_) => widget.mapController,
              builder: (context, controller) {
                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: controller.initialPosition,
                    zoom: controller.defaultMapZoom,
                  ),
                  onMapCreated:
                      (GoogleMapController googleMapController) async {
                    widget.mapController
                        .setGoogleController(googleMapController);
                    widget.mapController
                        .checkLocationPermission(_showLocationServiceDialog);
                    widget.mapController
                        .enableLocationService(_showLocationPermissionDialog);
                    widget.mapController.goToUserLocation();
                  },
                  onCameraMove: (position) {
                    widget.mapController.cameraPosition = position.target;
                  },
                  onCameraIdle: () async {
                    await widget.mapController.getPositionPlaceName();
                    setState(() {});
                  },
                  markers: markers,
                  polylines: polylines,
                );
              }),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: GestureDetector(
              onTap: () async {
                final results = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPlacesScreen();
                    },
                  ),
                );

                if (results is LatLng) {
                  widget.mapController.moveCameraToPosition(results);
                }
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            enabled: false,
                            hintText: 'Search places',
                            border: InputBorder.none,
                            icon: Icon(Icons.search_sharp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showMidScreenPointer)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Icon(
                  Icons.location_pin,
                  size: 48.0,
                  color: Colors.red,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          widget.mapController.goToUserLocation();
                        },
                        icon: Icon(
                          Icons.my_location,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeMode();
                        },
                        icon: Icon(
                          Icons.nightlight,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BottomSheetNavigator(
                bottomSheetNavigatorKey: bottomSheetNavigatorKey,
                mapController: widget.mapController,
                onMapChanged: () {
                  updateMap(widget.mapController.points);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget contdec(String img) {
    return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.fitWidth),
        ));
  }

  void updateMap(List<dynamic> points) async {
    // clear old stuff
    markers.clear();
    polylines.clear();

    List<LatLng> po =
        points.map((f) => LatLng(f.latitude, f.longitude)).toList();

    late String route;
    if (points.length == 2) {
      route = await googleMapsService.getRouteCoordinatesBetweenTwoPoints(
        po[0],
        po[1],
      );
    } else if (points.length > 2) {
      route = await googleMapsService.getRouteCoordinatesForMultiplePoints(po);
    } else {
      return;
    }

    final polyline = widget.mapController.generatePolylineFromRoute(route);

    setState(() {
      markers.addAll(
        widget.mapController.points.map(
          (point) => Marker(
            markerId: MarkerId(point.toString()),
            position: point,
            infoWindow: InfoWindow(title: "step", snippet: "go here"),
            icon: BitmapDescriptor.defaultMarker,
          ),
        ),
      );

      polylines.add(polyline);
    });
  }

  @override
  void dispose() {
    widget.mapController.googleMapController?.dispose();
    super.dispose();
  }
}
