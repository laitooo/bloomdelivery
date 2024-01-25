import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'ui/views/splash.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  setupServiceLocator();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/translations', // <-- change patch to your
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    useOnlyLangCode: true,
    //assetLoader: CodegenLoader()
  ));
}

const balbirGradient = LinearGradient(
    colors: [Color(0xFFFF82b8), Color(0xFFFF91ca)],
    tileMode: TileMode.clamp,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);

/* const tajribaBackgroundLighter = Color(0xFFeffcef);
const tajribaBackground = Color(0xFFccedd2);
const tajribaPrimary = Color(0xFF21bf73);
const tajribaSecondayLighter = Color(0xFFfd5e53);
const tajribaPrimaryLighter = Color(0xFF94d3ac);
 */
/* const tajribaBackgroundLighter = Color(0xFFefecec); */
const tajribaBackgroundLighter = Color(0xFFffffff);
var tajribaBackground = Colors.grey[200];
const tajribaPrimary = Color.fromARGB(255, 81, 149, 32);
const tajribaAccent = Color.fromARGB(255, 210, 164, 161);
const tajribaSeconday = Color.fromARGB(255, 4, 226, 100);
const tajribaPrimaryLighter = Color(0xFF94d3ac);

late TextStyle TajawalbodyText1;
Map<int, Color> bluecareCustomColor = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .8),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(109, 92, 126, 1.0),
};
MaterialColor bluecareColor = MaterialColor(0xFF880E4F, bluecareCustomColor);
MaterialColor bcColor = MaterialColor(0xFFf75a0d, bluecareCustomColor);
MaterialColor bcSColor = MaterialColor(0xFF849547, bluecareCustomColor);
MaterialColor bcSTColor = MaterialColor(0xFFd3dbff, bluecareCustomColor);
final routeObserver = RouteObserver<PageRoute>();
const duration = const Duration(milliseconds: 300);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = tajribaPrimary;
  //Color accentColor = bluecareCustomColor[900];
  Color accentColor = tajribaAccent;

  @override
  void initState() {
    super.initState();
    //myLocale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: tajribaBackgroundLighter,
        snackBarTheme: SnackBarThemeData(),
        /* bottomAppBarTheme: BottomAppBarTheme(
          color: tajribaBackgroundLighter,
          elevation: 2,
        ),
        bottomAppBarColor: tajribaBackgroundLighter, */
        dialogTheme: DialogTheme(
          backgroundColor: tajribaBackground,
          contentTextStyle: TextStyle(
              fontFamily: 'Tajawal',
              color: Colors.black87,
              fontWeight: FontWeight.bold),
          titleTextStyle: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black87,
          ),
          //contentTextStyle: Theme.of(context).textTheme.bodyText2,
        ),

        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          toolbarTextStyle: TextTheme(
            titleSmall: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal',
            ),
            headlineSmall: TextStyle().copyWith(
              color: Colors.black,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              //height: 2,
            ),
            titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  //height: 2,
                ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleSmall: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal',
            ),
            headlineSmall: TextStyle().copyWith(
              color: Colors.black,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
              //height: 2,
            ),
            titleLarge: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                  //height: 2,
                ),
          ).titleLarge,
        ),
        cardTheme: CardTheme(
          color: tajribaBackgroundLighter,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),

        primaryColor: primaryColor,
        brightness: Brightness.light,
        hintColor: accentColor,
        fontFamily: 'Tajawal',
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          disabledColor: Colors.grey,
          minWidth: 20,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        buttonBarTheme: ButtonBarThemeData(
            buttonPadding: EdgeInsets.only(left: 8, right: 8),
            buttonTextTheme: ButtonTextTheme.normal),

        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: tajribaPrimary,
            fontFamily: 'Tajawal',
            //fontSize: 18,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontFamily: 'Tajawal',
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Tajawal',
            //height: 2,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontFamily: 'Tajawal',
          ),
          titleSmall: TextStyle(
              //height: 2,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Tajawal'),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            height: 1.5,
            fontSize: 14,
            fontFamily: 'Tajawal',
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            //height: 1,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Tajawal',
            //height: 2,
            color: primaryColor,
          ),
        ),
        //iconTheme: IconThemeData(color: Colors.grey, size: 100, opacity: 1,),

        inputDecorationTheme: InputDecorationTheme(
          /* enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ), */

          contentPadding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tajribaPrimary),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: tajribaBackgroundLighter,

          labelStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Tajawal',
            color: Colors.grey,
          ),
          //contentPadding: EdgeInsetsDirectional.only(top: 16),
          //isDense: true,
          prefixStyle: Theme.of(context).textTheme.bodyMedium,
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: bluecareColor).copyWith(background: tajribaBackground),
      ),
      home: Splash(),
      navigatorObservers: [routeObserver],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
