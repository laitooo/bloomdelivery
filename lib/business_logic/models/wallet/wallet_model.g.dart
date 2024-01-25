// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      user: Wallet.userFromJson(json['user']),
      id: json['id'] as int,
      transaction: (json['transaction'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'name': instance.name,
      'balance': instance.balance,
      'user': instance.user,
      'id': instance.id,
      'transaction': instance.transaction,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      wallet: Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'wallet': instance.wallet,
      'id': instance.id,
    };
