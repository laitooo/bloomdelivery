import 'dart:async';

import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:bloomdeliveyapp/ui/views/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bloomdeliveyapp/ui/views/login_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final LocalStorageService _localStorageService =
      serviceLocator<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      _onSplashEnd();
    });

    return Scaffold(
        // backgroundColor: Theme.Colors.maincolor,
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset("assets/img/logo.png", fit: BoxFit.contain),
    ));
  }

  _onSplashEnd() async {
    await SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('token') != null &&
          prefs.getString('token')!.isNotEmpty) {
        _localStorageService.getMyProfile().then((profile) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DeliveryMapScreen()));
        });
        /* var route = MaterialPageRoute(
            builder: (BuildContext context) => DeliveryMapScreen(
                  mainViewModel: serviceLocator<MainViewModel>(),
                  profileViewModel: serviceLocator<MyProfileViewModel>(),
                ));
        Navigator.of(context).pushReplacement(route); */
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Login()));
      }
    });
  }
}
