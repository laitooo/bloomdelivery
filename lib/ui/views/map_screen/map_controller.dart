import 'package:bloomdeliveyapp/services/google_map/google_map_service.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapController {
  final googleMapService = serviceLocator<GoogleMapsServices>();

  LatLng? cameraPosition;
  String? currentPlace;
  Position? currentUserPosition;

  GoogleMapController? googleMapController;

  int routeWidth = 4;
  Color routeColor = Colors.blue;
  final defaultMapZoom = 16.0;
  final LatLng initialPosition = LatLng(25.276987, 55.296249);


  final List<LatLng> points = [];
  final List<String> placesNames = [];
  get hasStart => points.length > 0;
  get hasEnd => points.length > 1;

  void setGoogleController(googleMapController) {
    this.googleMapController = googleMapController;
  }

  addPoint() {
    if (cameraPosition != null) {
      points.add(cameraPosition!);
      placesNames.add(currentPlace ?? "Unknown place");
    }
  }

  addStep() {
    if (cameraPosition != null) {
      points.insert(points.length - 1, cameraPosition!);
      placesNames.insert(points.length - 1, currentPlace ?? "Unknown place");
    }
  }

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
      currentUserPosition = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high,
      );

    } catch (e) {
      print('Error getting location: $e');
    }
  }

  moveToCurrentPosition() async {
    if (currentUserPosition != null && googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentUserPosition!.latitude,
              currentUserPosition!.longitude,
            ),
            zoom: defaultMapZoom,
          ),
        ),
      );
    }
  }

  moveCameraToPosition(LatLng position) async {
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: defaultMapZoom,
          ),
        ),
      );
    }
  }

  Future<String?> getPositionPlaceName() async {
    currentPlace = await googleMapService.getPlaceName(cameraPosition!);
    return currentPlace;
  }

  Polyline generatePolylineFromRoute(String route) {
    return Polyline(
      polylineId: PolylineId(points[1].toString()),
      points: _convertToLatLng(_decodePoly(route)),
      color: routeColor,
      width: routeWidth,
    );
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negative then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    return lList;
  }
}
