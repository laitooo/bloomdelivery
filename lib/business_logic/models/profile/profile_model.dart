import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(nullable: true)
class Profile {
  String username;
  late String email;
/*   String? password; */
  int id;
  String phone;
  String fullname;
  bool confirmedPhone;
  String? otp;
  //Wallet? wallet;
  //List<Notice?>? notices;
  //String avatar;
  //Profile profile;
  Profile({
    required this.email,
    required this.username,
/*     this.password, */
    required this.id,
    required this.phone,
    required this.fullname,
    required this.confirmedPhone,
    this.otp,
    //this.wallet,
    //required this.notices,
    //this.avatar,
    //this.profile,
  });
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
