import 'package:bloomdeliveyapp/ui/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;
  AppThemeData theme = LightThemeData();

  changeMode() {
    if (isDarkMode) {
      useLightMode();
    } else {
      useDarkMode();
    }
  }

  useLightMode() {
    isDarkMode = false;
    theme = LightThemeData();
    notifyListeners();
  }

  useDarkMode() {
    isDarkMode = true;
    theme = DarkThemeData();
    notifyListeners();
  }
}

extension ThemeProviderExtension on BuildContext {
  AppThemeData get theme => Provider.of<ThemeProvider>(this).theme;
}