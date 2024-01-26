import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapController extends ChangeNotifier {
  Position? currentPosition;
  final defaultMapZoom = 16.0;
  late GoogleMapController googleMapController;

  goToUserLocation() async {
    await loadUserLocation();
    await moveToCurrentPosition();
  }

  enableLocationService(Function onShowLocationPermissionDialog) async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      onShowLocationPermissionDialog();
    }
  }

  checkLocationPermission(Function onShowLocationPermissionDialog) async {
    var status = await Permission.location.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      onShowLocationPermissionDialog();
    } else {
      await Permission.location.request().then((value) {
        if (value.isDenied || status.isPermanentlyDenied) {
          onShowLocationPermissionDialog();
        }
      });
    }
  }

  loadUserLocation() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high,
      );

      print(
          'Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  moveToCurrentPosition() async {
    if (currentPosition != null) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
            zoom: defaultMapZoom,
          ),
        ),
      );
    }
  }

  // Future<void> _determinePosition() async {
  //
  //   Position position = await Geolocator.getCurrentPosition();
  //   // setState(() {
  //   // _searchController.text = '${position.latitude}, ${position.longitude}';
  //   // _userLocationMarker = Marker(
  //   //   markerId: MarkerId('currentLocation'),
  //   //   position: _currentPosition,
  //   //   draggable: true,
  //   //   onDragEnd: (newPosition) {
  //   //     _updatePosition(CameraPosition(target: newPosition, zoom: 14));
  //   //   },
  //   // );
  // }
}
