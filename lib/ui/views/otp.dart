import 'package:bloomdeliveyapp/main.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/ui/views/map_screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:url_launcher/url_launcher.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var _forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  OTPTextField _otpTextField = OTPTextField();
  bool _wrongPin = false;
  bool _hasCallSupport = false;
  Future<void>? _launched;

  var _phone = '3466';

  String _pin = '';
  @override
  void initState() {
    // Check for phone call support.

    canLaunchUrl(Uri(scheme: 'tel', path: '${_phone}')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Image.asset(
                    "assets/img/otp.png",
                    //color: tajribaPrimary,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "تأكيد رقم الهاتف",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 8.0, bottom: 8),
                        child: Text(
                          "ادخل رمز التحقق الذي تم إرساله إلى",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "0999999999",
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                      ),
                    ],
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      _pin = pin;
                    },
                    onCompleted: (pin) {
                      /*  if (profileViewModel.profile.otp == pin) {
                              setState(() {
                                _wrongPin = false;
                              });
                              profileViewModel.confirmPhone();
                            } else {
                              _wrongPin = true;
                              setState(() {});
                            } */
                    },
                  ),
                ),
                if (_wrongPin)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "عفواً، رمز التحقق خاطئ",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.red),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _hasCallSupport
                          ? Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8.0),
                                child: Text(
                                  "لم تتحصل على رمز التحقق؟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 8.0),
                              child: Text(
                                "لم تتحصل على رمز التحقق؟",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                      _hasCallSupport
                          ? Expanded(
                              child: TextButton(
                                onPressed: () => setState(() {
                                  _launched = _makePhoneCall(_phone);
                                }),
                                child: Text(
                                  "اتصل بخدمة العملاء",
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                _hasCallSupport
                    ? Container()
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "الرجاء الاتصال بخدمة العملاء على الرقم $_phone",
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      //maximumSize:  MaterialStateProperty.all<Size>(),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(18)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(tajribaPrimary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _wrongPin = true;
                      setState(() {});
                    },
                    child: Text(
                      "التحقق والمتابعة",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// logic to validate otp return [null] when success else error [String]
  Future<String?> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == 1234.toString()) {
      return null;
    } else {
      return "رمز Otp المدخل خاطئ";
    }
  }

  // action to be performed after OTPScreen validation is success
  void moveToNextScreen(context) {
    /*  Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                mainViewModel: mainViewModel,
                profileViewModel: profileViewModel))); */
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DeliveryMapScreen()));
  }
}
