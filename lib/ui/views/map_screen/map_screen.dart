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
  late double toolbarHeight;
  final LatLng _initialPosition =
      LatLng(25.276987, 55.296249); // Example coordinates
  final bottomSheetNavigatorKey = GlobalKey<BottomSheetNavigatorBuilderState>();

  final TextEditingController _searchController = TextEditingController();
  // Declare _userLocationMarker as nullable
  Marker? _userLocationMarker;

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
              builder: (context, _) {
                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    widget.mapController.googleMapController = controller;
                    widget.mapController.checkLocationPermission(_showLocationServiceDialog);
                    widget.mapController.enableLocationService(_showLocationPermissionDialog);
                    widget.mapController.goToUserLocation();
                    // _setMapStyle();
                  },
                  markers: Set.of(_userLocationMarker != null
                      ? [_userLocationMarker!]
                      : []),
                );
              }),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Destination Address',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
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
                  SizedBox(
                      width: 10), // Space between the icon and the search box
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
                          hintText: 'Your Location',
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
              BottomSheetNavigator(
                bottomSheetNavigatorKey: bottomSheetNavigatorKey,
                mapController: widget.mapController,
                onMapChanged: (value) {
                  setState(() {
                    // showRandomIconButton = value;
                  });
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
}
