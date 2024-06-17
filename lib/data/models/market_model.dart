import 'package:crypto_track/domain/entities/market_entite.dart';
import 'package:crypto_track/extensions/double.dart';

class MarketModel extends Market {
  MarketModel({
    required Map<String, double> totalMarketCap,
    required Map<String, double> totalVolume,
    required Map<String, double> marketCapPercentage,
    required double marketCapChangePercentage24HUsd,
  }) : super(
          totalMarketCap: totalMarketCap,
          totalVolume: totalVolume,
          marketCapPercentage: marketCapPercentage,
          marketCapChangePercentage24HUsd: marketCapChangePercentage24HUsd,
        );

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      totalMarketCap: Map<String, double>.from(json['total_market_cap']),
      totalVolume: Map<String, double>.from(json['total_volume']),
      marketCapPercentage: Map<String, double>.from(json['market_cap_percentage']),
      marketCapChangePercentage24HUsd: json['market_cap_change_percentage_24h_usd'],
    );
  }

  String get marketCap {
    if (totalMarketCap.containsKey('usd')) {
      return '\$${totalMarketCap['usd']!.formattedWithAbbreviations()}';
    }
    return '';
  }

  String get volume {
    if (totalVolume.containsKey('usd')) {
      return '\$${totalVolume['usd']!.formattedWithAbbreviations()}';
    }
    return '';
  }

  String get btcDominance {
    if (marketCapPercentage.containsKey('btc')) {
      return marketCapPercentage['btc']!.asPercentString();
    }
    return '';
  }
}
