import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  bool _hasCallSupport = false;
  Future<void>? _launched;

  var _phone = '3466';

  @override
  void initState() {
    canLaunchUrl(Uri(scheme: 'tel', path: '${_phone}')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,

        //title: Text('نسيت كلمة المرور'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "لا تقلق! اعد تعيين كلمة المرور عبر الإتصال بخدمة العملاء من رقم الهاتف المستخدم عند عملية التسجيل",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                _hasCallSupport
                    ? TextButton(
                        onPressed: () => setState(() {
                          _launched = _makePhoneCall(_phone);
                        }),
                        child: Text(
                          "اتصل بخدمة العملاء",
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "الرجاء الاتصال بخدمة العملاء على الرقم $_phone",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
