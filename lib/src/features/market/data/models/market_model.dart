import 'package:crypto_track/src/features/market/domain/entities/market_entite.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_model.freezed.dart';
part 'market_model.g.dart';

@freezed
class MarketModel extends MarketEntity with _$MarketModel{
  factory MarketModel({
    required double totalMarketCap,
    required double totalVolume,
    required double marketCapPercentage,
    required double btcDominance
  }) = _MarketModel;

  factory MarketModel.fromJson(Map<String, dynamic> json) => _$MarketModelFromJson(json);
}