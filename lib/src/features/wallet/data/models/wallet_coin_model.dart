import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';

class WalletCoinModel extends WalletCoinEntity {
  WalletCoinModel({
    required super.amount,
    required super.imageUrl,
    required super.id,
    required super.investmentValue,
  });

  // Factory constructor to create an instance from JSON
  factory WalletCoinModel.fromJson(Map<String, dynamic> json) {
    return WalletCoinModel(
      amount: (json['amount'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      id: json['id'] as String,
      investmentValue: (json['investmentValue'] as num).toDouble(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'imageUrl': imageUrl,
      'id': id,
      'investmentValue': investmentValue,
    };
  }

  factory WalletCoinModel.fromEntity(WalletCoinEntity entity) {
    return WalletCoinModel(
      amount: entity.amount,
      imageUrl: entity.imageUrl,
      id: entity.id,
      investmentValue: entity.investmentValue,
    );
  }
}
