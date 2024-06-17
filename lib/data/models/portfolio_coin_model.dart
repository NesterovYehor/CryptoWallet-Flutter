import 'package:crypto_track/domain/entities/protfolio_coin_entitey.dart';

class PortfolioCoinModel extends PortfolioCoin{
  PortfolioCoinModel({
    required super.amount, 
    required super.imageUrl, 
    required super.index});

  factory PortfolioCoinModel.fromJson(Map<String, dynamic> json) {
    return PortfolioCoinModel(
      index: json['index'], 
      imageUrl: json['imageUrl'], 
      amount: json['amount']
    );
  }
}