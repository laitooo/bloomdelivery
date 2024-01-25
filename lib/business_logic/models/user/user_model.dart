import 'package:bloomdeliveyapp/business_logic/models/wallet/wallet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(nullable: true)
class User {
  String username;
  late String email;
  String? password;
  int id;
  String phone;
  String fullname;
  bool confirmedPhone;
  String? otp;
  Wallet? wallet;
  String? type;
  //List<Notice?>? notices;
  //String avatar;
  //Profile profile;
  User({
    required this.email,
    required this.username,
    this.password,
    required this.id,
    required this.phone,
    required this.fullname,
    required this.confirmedPhone,
    this.otp,
    this.wallet,
    this.type,
    //required this.notices,
    //this.avatar,
    //this.profile,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
