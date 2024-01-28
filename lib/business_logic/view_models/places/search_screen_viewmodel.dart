import 'package:bloomdeliveyapp/business_logic/models/place/place_model.dart';
import 'package:bloomdeliveyapp/services/google_map/google_map_service.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/foundation.dart';

class SearchScreenViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool hasLoaded = false;
  final _googleMapService = serviceLocator<GoogleMapsServices>();

  List<Place> results = [];

  searchQuery(String query) async {
    print('test search $query');
    isLoading = true;
    hasLoaded = false;
    notifyListeners();
    _googleMapService.searchPlace(query).then((value) {
      results = value;
      isLoading = false;
      hasLoaded = true;
      notifyListeners();
      print('results $results');
    });
  }

  cancelSearch() {
    isLoading = false;
    hasLoaded = false;
    results = [];
    notifyListeners();
  }
}