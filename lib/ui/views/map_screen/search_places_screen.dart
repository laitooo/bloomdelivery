import 'package:bloomdeliveyapp/business_logic/view_models/places/search_screen_viewmodel.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({super.key});

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  final _controller = TextEditingController();
  final searchScreenViewModel = serviceLocator<SearchScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.green,
        leadingWidth: 40,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_backspace_outlined,
              size: 30,
              color: Colors.white,
            ),),
        actions: _appBarActions(),
      ),
      body: Stack(
        children: [
          ChangeNotifierProvider(
            create: (_) => searchScreenViewModel,
            child: Consumer<SearchScreenViewModel>(
              builder: (context, searchScreenViewModel, child) {
                if (searchScreenViewModel.hasLoaded) {
                  return ListView(
                    children: searchScreenViewModel.results
                        .map(
                          (result) => InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Text(
                                result.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(
                                LatLng(
                                  result.latitude,
                                  result.longitude,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                }

                if (searchScreenViewModel.isLoading) {
                  return Center(
                    child: Text("Loading..."),
                  );
                }

                return Center(
                  child: Text("Start searching places"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _appBarActions() {
    return [
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        width: MediaQuery.of(context).size.width - 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (text) {
                  if (text.isEmpty) {
                    searchScreenViewModel.cancelSearch();
                  } else {
                    if (text.length > 2) {
                      searchScreenViewModel.searchQuery(text);
                    }
                  }
                },
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  hintText: "Search places",
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
