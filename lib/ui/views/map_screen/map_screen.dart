import 'package:bloomdeliveyapp/services/google_map/google_map_service.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/bottom_sheet_navigator.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_builder.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  final TextEditingController _searchController = TextEditingController();

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
                  onMapCreated: (GoogleMapController googleMapController) {
                    controller.googleMapController = googleMapController;
                    controller
                        .checkLocationPermission(_showLocationServiceDialog);
                    controller
                        .enableLocationService(_showLocationPermissionDialog);
                    controller.goToUserLocation();
                  },
                  onCameraMove: (position) {
                    widget.mapController.cameraPosition = position.target;
                  },
                  onCameraIdle: () async {
                    await widget.mapController.getPositionPlaceName();
                    setState(() {
                    });
                  },
                  markers: markers,
                  polylines: polylines,
                );
              }),
          Positioned(
            top: MediaQuery.of(context).padding.top +
                10, // Adjust the position as needed
            left: 10,
            right: 10,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black),
                    onPressed: () {
                      // TODO: Open drawer or navigation menu
                    },
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _searchController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Search places',
                          border: InputBorder.none,
                          icon: Icon(Icons.location_searching),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 20),
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
              BottomSheetNavigator(
                bottomSheetNavigatorKey: bottomSheetNavigatorKey,
                mapController: widget.mapController,
                onMapChanged: () {
                  updateMap(widget.mapController.points);
                },
              ),
            ],
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
            )
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
}
