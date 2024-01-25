import 'package:bloomdeliveyapp/ui/views/map_screen/bottom_sheet_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

final scaffoldKey2 = new GlobalKey<ScaffoldState>();

class DeliveryMapScreen extends StatefulWidget {
  int? seletedIndex = 0;
  DeliveryMapScreen({Key? key, this.seletedIndex}) : super(key: key);
  @override
  DeliveryMapScreenState createState() => DeliveryMapScreenState();
}

class DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late double toolbarHeight;

  late GoogleMapController mapController;
  final LatLng _initialPosition =
      LatLng(25.276987, 55.296249); // Example coordinates
  final bottomSheetNavigatorKey = GlobalKey<BottomSheetNavigatorBuilderState>();

  final TextEditingController _searchController = TextEditingController();
  // Declare _userLocationMarker as nullable
  Marker? _userLocationMarker;
  late LatLng _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updatePosition(CameraPosition _position) {
    setState(() {
      _currentPosition = _position.target;
      _searchController.text =
          'Lat: ${_position.target.latitude}, Lng: ${_position.target.longitude}';
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 14.0,
        ),
      ));
      _searchController.text = '${position.latitude}, ${position.longitude}';
      _userLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: _currentPosition,
        draggable: true,
        onDragEnd: (newPosition) {
          _updatePosition(CameraPosition(target: newPosition, zoom: 14));
        },
      );
    });
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set.of(
                _userLocationMarker != null ? [_userLocationMarker!] : []),
          ),
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
                // mapController: mapController,
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
