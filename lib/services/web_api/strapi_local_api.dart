import 'dart:convert';
import 'dart:io';
import 'package:bloomdeliveyapp/business_logic/models/booking/booking_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/notice/notice_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:path/path.dart';
import 'package:http/http.dart'
    show
        ByteStream,
        MultipartFile,
        MultipartRequest,
        get,
        post,
        put,
        Response,
        delete;

class StrapiLocalApi {
  final LocalStorageService _storageService =
      serviceLocator<LocalStorageService>();
      // url
  //final _host = 'http://3.145.118.79:1337';
  final _host = 'http://192.168.0.34:1337';
  //final _host = 'http://167.235.229.127:8888';
  //final _host = 'http://127.0.0.1:1337';
  //final _port = 1337;
  String _path = '';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=utf-8'
  };

  Future<Response> login(identifier, password) async {
    _path = 'api/auth/local';
    final loginUrl = _host + "/" + _path;
    dynamic bodyToSend = {
      'identifier': identifier,
      'password': password,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }

  Future<Response> register(String fullname, String username, String email,
      String phonenumber, String password, String code) async {
    _path = 'api/auth/local/register';
    final loginUrl = _host + "/" + _path;
    username = phonenumber;
    dynamic bodyToSend = {
      'fullname': fullname,
      'username': username,
      'email': email,
      'phone': phonenumber,
      'password': password,
      'confirmedPhone': false,
      'otp': code,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }

  Future<Response> sendOtp(String phonenumber, String otp) async {
    final url = '';
    final _h = {
      'Cookie':
          'laravel_session=eyJpdiI6IllQcXlTR3JcL0J5Z2p6b05FYUxIazZ3PT0iLCJ2YWx1ZSI6InllWFdcL0Z1QkNyNTE4eDdnNVVDS1lqM1VKODJjUDFWOW1Ob2x1R0FPSkRqSGRGOHlVaG9URUNyaFlsbm1JSk1tUm9YaGhPN1JkR0kwZWhcLzU5M2hEOFE9PSIsIm1hYyI6IjQ1NTA5OTRhOTYzY2ZlNWIzOTkwYWQ2ODdmNGFhNjM0NzM1NzU5MzdlYTFkNjU4MTRjOGE5NzgyNTMzNTIwOTEifQ%3D%3D',
    };
    dynamic bodyToSend = {
      'to': '249' + phonenumber,
      'from': 'Bloom Delivey App',
      'sms': 'your otp is $otp',
      'unicode': '1',
      'api_key': ''
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(url), body: body, headers: _headers);
  }

  Future<Response> transferRequest(
      {required String cardNumber,
      required String amount,
      required String ipin,
      required String month,
      required String year}) async {
    final token = await _storageService.getToken();
    final User user = await _storageService.getCurrentUser();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    dynamic bodyToSend = {
      'cardno': cardNumber,
      'amount': amount,
      'ipin': ipin,
      'expdate': month + '/' + year,
    };
    final uri = '';

    ///final uri = _path;
    var body = json.encode(bodyToSend);
    print(body);
    print(uri);
    return await post(Uri.parse(uri), body: bodyToSend);
  }

  Future<Response> transferMoney(
      {required String cardNumber,
      required String amount,
      required String ipin,
      required String month,
      required String year}) async {
    final token = await _storageService.getToken();
    final User user = await _storageService.getCurrentUser();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    dynamic bodyToSend = {
      "data": {
        'type': 'income',
        'amount': int.parse(amount),
        'user': user,
      },
    };
    _path = 'api/transactions';
    final uri = _host + "/" + _path;
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(uri), body: body, headers: headers);
  }

  Future<Response> saveNotice(Notice notice) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    if (notice.id != null) {
      _path = 'api/notices/${notice.id}';
    } else {
      _path = 'api/notices';
    }

    final uri = _host + "/" + _path;

    //var bodyToSend = {"data": notice};
    var bodyToSend = {
      "data": {
        "description": notice.description,
        "formattedAddress": notice.formattedAddress,
        "latlng": notice.latlng,
        "status": null,
        "type": notice.type,
        "user": notice.user!.id,
      }
    };

    var body = jsonEncode(bodyToSend);
    try {
      if (notice.id != null) {
        return await put(Uri.parse(uri), body: body, headers: headers);
      } else {
        return await post(Uri.parse(uri), body: body, headers: headers);
      }
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  Future<Response> createNewWallet() async {
    final token = await _storageService.getToken();
    final user = await _storageService.getCurrentUser();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };

    _path = 'api/wallets';

    final uri = _host + "/" + _path;

    //var bodyToSend = {"data": notice};
    //User user = await _storageService.getCurrentUser();
    var bodyToSend = {
      "data": {
        "name": user.fullname,
        "user": user.id,
      }
    };

    var body = jsonEncode(bodyToSend);
    print(body);
    try {
      return await post(Uri.parse(uri), body: body, headers: headers);
    } catch (e) {
      String error = '{"error": {"message": "خطأ في الإتصال"}}';
      return Response(error, 404);
    }
  }

  Future<Response> saveBooking(Booking booking) async {
    final token = await _storageService.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    if (booking.id != null) {
      _path = 'api/bookings/${booking.id}';
    } else {
      _path = 'api/bookings';
    }

    final uri = _host + "/" + _path;

    //var bodyToSend = {"data": notice};
    User user = await _storageService.getCurrentUser();
    var bodyToSend = {
      "data": {
        "name": booking.name,
        "address": booking.address,
        "phone": booking.phone,
        "seat": booking.seat,
        "trip": booking.trip,
        //"ticket": booking.ticket,
        "payment": 'online',
        "cancel": booking.cancel,
        "user": user.id,
      }
    };

    var body = jsonEncode(bodyToSend);
    try {
      if (booking.id != null) {
        return await put(Uri.parse(uri), body: body, headers: headers);
      } else {
        return await post(Uri.parse(uri), body: body, headers: headers);
      }
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  Future searchProfiles(String q) async {
    var response;
    return await searchProfiles(q).then((value) {
      response = value;
      return response;
    });
  }

  Future<Response> getMyNotices() async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/mynotices';
    final uri = _host + "/" + _path;
    try {
      return await get(Uri.parse(uri), headers: headers);
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  Future<Response> getMyBookings() async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/mybookings';
    final uri = _host + "/" + _path;
    try {
      return await get(Uri.parse(uri), headers: headers);
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  // create a function to reset the password
  Future<Response> resetPassword(String email) async {
    _path = 'api/auth/reset';
    final loginUrl = _host + "/" + _path;
    dynamic bodyToSend = {
      'email': email,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }

  Future getTrips() async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/trips';
    final uri = _host + "/" + _path;
    try {
      return await get(Uri.parse(uri), headers: headers);
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  // get trips by from, to and date
  Future getTripsByFromToDate(String from, String to, String date) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/trips/from/$from/to/$to/date/$date';
    final uri = _host + "/" + _path;
    try {
      return await get(Uri.parse(uri), headers: headers);
    } catch (e) {
      String error = '{"error": {"message": "Connection Error"}}';
      return Response(error, 404);
    }
  }

  Future getBalance() async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    User user = await _storageService.getCurrentUser();
    _path = 'api/userWallet/${user.id}';
    final findUrl = _host + "/" + _path;
    return await get(Uri.parse(findUrl), headers: headers);
  }

  Future getProfileByUser(int id) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'profiles/user/$id';
    final findUrl = _host + "/" + _path;
    return await get(Uri.parse(findUrl), headers: headers);
  }

  Future getProfileById(String id) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'profiles/$id';
    final findUrl = _host + "/" + _path;
    return await get(Uri.parse(findUrl), headers: headers);
  }

  // create forgot password function to send email to user with reset password link and token to reset password
  Future<Response> forgotPassword(String email) async {
    _path = 'api/auth/forgot-password';
    final loginUrl = _host + "/" + _path;
    dynamic bodyToSend = {
      'email': email,
    };
    var body = json.encode(bodyToSend);
    return await post(Uri.parse(loginUrl), body: body, headers: _headers);
  }

  Future updateProfile(Profile profile) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/users/${profile.id}';

    final putUrl = _host + "/" + _path;
    profile.username = profile.phone;
    var body = jsonEncode(profile);
    var bodyToSend = {
      "name": 'Tobin ‎2',
      "nickname": null,
      "job": null,
      "bio": null,
      "formattedAddress": null,
      "certificate": null,
      "relationshipStatus": null,
      "gender": null,
      "isAlive": false,
      "isFake": true,
      "birthdate": null,
      "deathdate": null,
      "profileImage": null
    };

    return await put(Uri.parse(putUrl), body: body, headers: headers);
  }

  Future confirmPhone() async {
    final token = await _storageService.getToken();
    final user = await _storageService.getCurrentUser();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    _path = 'api/users/${user.id}';

    final putUrl = _host + "/" + _path;
    //profile.username = profile.phone;
    //var body = jsonEncode(profile);
    var bodyToSend = {
      "confirmedPhone": true,
    };

    var body = jsonEncode(bodyToSend);
    print(body);
    return await put(Uri.parse(putUrl), body: body, headers: headers);
  }

  Future updateProfileImage(Profile profile, File profileImage) async {
    final token = await _storageService.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token'
    };
    /*  if (profile.profileImage != null) {
      _path = 'upload?id=${profile.profileImage.id}';
    } else {
      _path = 'upload';
    } */

    final putUrl = _host + "/" + _path;
    // open a bytestream
    var stream = new ByteStream(Stream.castFrom(profileImage.openRead()));
    // get file length
    var length = await profileImage.length();

    // string to uri
    var uri = Uri.parse(putUrl);

    // create multipart request
    var request = new MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new MultipartFile('files', stream, length,
        filename: basename(profileImage.path));

    // add file to multipart
    request.files.add(multipartFile);

    request.headers.addAll(headers);

    // send

    return await request.send();
    }
}
