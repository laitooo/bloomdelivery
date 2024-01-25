import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class Wallet {
  String name;
  double balance;
  @JsonKey(fromJson: userFromJson)
  User? user;
  int id;
  List<Transaction>? transaction;
  Wallet({
    required this.name,
    required this.balance,
    required this.user,
    required this.id,
    this.transaction,
  });
  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);

  static userFromJson(json) {
    if (json == null) return null;
  }
}

@JsonSerializable()
class Transaction {
  String type;
  double amount;
  Wallet wallet;
  int id;

  Transaction({
    required this.type,
    required this.amount,
    required this.wallet,
    required this.id,
  });
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
