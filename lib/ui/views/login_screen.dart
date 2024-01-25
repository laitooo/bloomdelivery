import 'package:bloomdeliveyapp/ui/views/forgot_password.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:bloomdeliveyapp/ui/views/otp.dart';
import 'package:bloomdeliveyapp/ui/views/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bloomdeliveyapp/business_logic/view_models/login/login_screen_viewmodel.dart';
import 'package:bloomdeliveyapp/main.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';

//import 'package:bloomdeliveyapp/ui/views/main/main_navigation_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginScreenViewModel loginScreenViewModel =
      serviceLocator<LoginScreenViewModel>();
  final LocalStorageService _localStorageService =
      serviceLocator<LocalStorageService>();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeUserName = FocusNode();
  TextEditingController signupUserNameController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();

  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _obscureTextLogin = true;

  final formKey = GlobalKey<FormState>();

  bool _saving = false;

  @override
  void initState() {
    _localStorageService.isLoggenIn().then((isLoggenIn) {
      /*    if (isLoggenIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainNavigationScreen()));
      } */
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ChangeNotifierProvider(
          create: (context) => loginScreenViewModel,
          child: Consumer<LoginScreenViewModel>(
              builder: (context, loginScreenViewModel, child) {
            if (loginScreenViewModel.isLoggedIn) {
              _localStorageService.getMyProfile().then((profile) {
                Future.microtask(
                  () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DeliveryMapScreen())),
                );
              });
            }
            return Scaffold(
              body: Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 48,
                        start: 20,
                        bottom: 24,
                      ),
                      child: Container(
                        height: 250,
                        child: Image.asset(
                          "assets/img/busway.png",
                          fit: BoxFit.scaleDown,
                          //color: tajribaPrimary,
                        ),
                      ),
                    ),
                    /*  Padding(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 48, start: 20),
                      child: Container(
                        height: 97,
                        child: Image.asset(
                          "assets/img/sila_logo_word.png",
                          fit: BoxFit.scaleDown,
                          //color: tajribaPrimary,
                        ),
                      ),
                    ), */
                    _buildSignIn(context),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSignIn(context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 48,
                ),
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ), */
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              focusNode: myFocusNodeUserName,
              controller: loginUserNameController,
              keyboardType: TextInputType.phone,
              maxLength: 9,
              validator: (value) {
                if (value!.isEmpty) {
                  return "مطلوب";
                } else if (value.length != 9) {
                  return "رقم الهاتف غير صحيح" +
                      " " +
                      "الرجاء التأكد من الصياغة";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                hintText: "رقم الهاتف",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  focusNode: myFocusNodePassword,
                  controller: loginPasswordController,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "مطلوب";
                    } else if (value.length < 4) {
                      return " كلمة المرور قصيرة جداً" +
                          "\n" +
                          "على الأقل 6 أحرف ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: _obscureTextLogin,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    hintText: "كلمة المرور",
                    suffixIcon: GestureDetector(
                      onTap: _toggleLogin,
                      child: Icon(
                        _obscureTextLogin
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              disabledColor: Theme.of(context).primaryColor.withAlpha(200),
              disabledTextColor: Colors.black12,
              textColor: Colors.white,
              highlightColor: Colors.transparent,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 16),
                child: loginScreenViewModel.saving
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "جاري تسجيل الدخول..",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white60),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8),
                            child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                )),
                          )
                        ],
                      )
                    : !loginScreenViewModel.isLoggedIn
                        ? Text(
                            "تسجيل الدخول",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Success",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 8),
                                child: SizedBox(
                                    child: Icon(
                                  Icons.check_circle_outline_outlined,
                                  size: 24,
                                )),
                              )
                            ],
                          ),
              ),
              onPressed: !loginScreenViewModel.saving
                  ? () => {
                        if (formKey.currentState!.validate())
                          {
                            formKey.currentState!.save(),
                            login(context),
                          }
                      }
                  : null,
            ),
          ),
          /*  Container(
            margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              disabledColor: Theme.of(context).primaryColor.withAlpha(200),
              disabledTextColor: Colors.black12,
              textColor: Colors.white,
              highlightColor: Colors.transparent,
              color: tajribaSeconday,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 16),
                child: Text(
                  "إنشاء حساب جديد",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
              onPressed: !loginScreenViewModel.saving
                  ? () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Register()))
                      }
                  : null,
            ),
          ), */
          // forgot password button here
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 16),
                child: Text(
                  "نسيت كلمة المرور؟",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                ),
              ),
              onPressed: !loginScreenViewModel.saving
                  ? () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPassword()))
                      }
                  : null,
            ),
          ),

          !loginScreenViewModel.isLoggedIn
              ? Text(
                  loginScreenViewModel.getFirstMessage(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.redAccent),
                )
              : Container(),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  login(context) {
    loginScreenViewModel.login(
        loginUserNameController.text, loginPasswordController.text);
    /*  if (loginScreenViewModel.isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainScreen(
                mainViewModel: serviceLocator<MainViewModel>(),
                profileViewModel: serviceLocator<MyProfileViewModel>(),
              )));
    } */
  }
}
