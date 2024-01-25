
import 'package:bloomdeliveyapp/ui/views/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bloomdeliveyapp/business_logic/view_models/login/login_screen_viewmodel.dart';
import 'package:bloomdeliveyapp/main.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:otp/otp.dart';

//import 'package:bloomdeliveyapp/ui/views/main/main_navigation_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  TextEditingController loginPasswordConfirmController =
      TextEditingController();

  bool _obscureTextLogin = true;

  final formKey = GlobalKey<FormState>();

  bool _saving = false;

  final FocusNode myFocusNodePhoneNumber = FocusNode();
  TextEditingController signupPhoneNumberController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  final FocusNode myFocusNodeFullName = FocusNode();
  TextEditingController signupFullNameController = TextEditingController();

  bool _obscureTextConfirmPassword = true;
  final FocusNode myFocusNodePasswordConfirm = FocusNode();

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
                        top: 16,
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              focusNode: myFocusNodeFullName,
              controller: signupFullNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "مطلوب";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                hintText: "الإسم الكامل",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              focusNode: myFocusNodeEmail,
              controller: signupEmailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "مطلوب";
                } else if (!EmailValidator.validate(value)) {
                  return "صيغة الإيميل غير صحيح";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                hintText: "الإيميل",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              focusNode: myFocusNodePhoneNumber,
              controller: signupPhoneNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "مطلوب";
                } else if (value.length != 9) {
                  return "رقم الهاتف غير صحيح" + " " + "يجب أن يكون 9 أرقام";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                hintText: "رقم الهاتف",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 16),
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
                          " يجب أن تكون 6 حروف على الأقل";
                    } else if (loginPasswordController.text !=
                        loginPasswordConfirmController.text) {
                      return "كلمة المرور لا تتطابق ";
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  focusNode: myFocusNodePasswordConfirm,
                  controller: loginPasswordConfirmController,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "مطلوب";
                    } else if (value.length < 4) {
                      return " كلمة المرور قصيرة جدا" +
                          "\n" +
                          " يجب أن تكون 6 حروف على الأقل";
                    } else if (loginPasswordController.text !=
                        loginPasswordConfirmController.text) {
                      return "كلمة المرور غير متطابقة ";
                    } else {
                      return null;
                    }
                  },
                  obscureText: _obscureTextConfirmPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    hintText: "تأكيد كلمة المرور",
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordConfirm,
                      child: Icon(
                        _obscureTextConfirmPassword
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
            margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              disabledColor: Theme.of(context).primaryColor.withAlpha(200),
              disabledTextColor: Colors.black12,
              textColor: Colors.white,
              highlightColor: Colors.transparent,
              color: Theme.of(context).primaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 16),
                child: loginScreenViewModel.saving
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "جاري إنشاء حسابك",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white60),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 8),
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
                            "إنشاء الحساب",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "تم إنشاء الحساب",
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
                            register(context),
                          }
                      }
                  : null,
            ),
          ),
          Container(
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
                  "لدي حساب بالفعل",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
              onPressed: !loginScreenViewModel.saving
                  ? () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Login()))
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

  void _togglePasswordConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  register(context) {
    final code = OTP.generateTOTPCodeString(
        'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
    print(code);
    loginScreenViewModel.register(
        signupFullNameController.text,
        signupPhoneNumberController.text,
        signupEmailController.text,
        signupPhoneNumberController.text,
        loginPasswordController.text,
        code);
  }
}
