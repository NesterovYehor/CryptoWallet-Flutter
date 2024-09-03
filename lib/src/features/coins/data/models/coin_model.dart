import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.image,
    required super.currentPrice,
    required super.marketCap,
    required super.marketCapRank,
    required super.fullyDilutedValuation,
    required super.totalVolume,
    required super.high24H,
    required super.low24H,
    required super.priceChange24H,
    required super.priceChangePercentage24H,
    required super.marketCapChange24H,
    required super.marketCapChangePercentage24H,
    required super.circulatingSupply,
    required super.totalSupply,
    required super.maxSupply,
    required super.ath,
    required super.athChangePercentage,
    required super.athDate,
    required super.atl,
    required super.atlChangePercentage,
    required super.atlDate,
    required super.roi,
    required super.lastUpdated, 
    required super.sparklineIn7D,
  });

  static List<CoinModel> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => CoinModel.fromJson(json)).toList();
  }


  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        id: json["id"] as String,
        symbol: json["symbol"] as String,
        name: json["name"] as String,
        image: json["image"] as String,
        currentPrice: (json["current_price"] as num).toDouble(),
        marketCap: (json["market_cap"] as num).toDouble(),
        marketCapRank: json["market_cap_rank"] as int,
        fullyDilutedValuation: json["fully_diluted_valuation"] != null ? (json["fully_diluted_valuation"] as num).toDouble() : null,
        totalVolume: (json["total_volume"] as num).toDouble(),
        high24H: (json["high_24h"] as num).toDouble(),
        low24H: (json["low_24h"] as num).toDouble(),
        priceChange24H: json["price_change_24h"] != null ? (json["price_change_24h"] as num).toDouble() : null,
        priceChangePercentage24H: json["price_change_percentage_24h"] != null ? (json["price_change_percentage_24h"] as num).toDouble() / 100 : null,
        marketCapChange24H: json["market_cap_change_24h"] != null ? (json["market_cap_change_24h"] as num).toDouble() : null,
        marketCapChangePercentage24H: json["market_cap_change_percentage_24h"] != null ? (json["market_cap_change_percentage_24h"] as num).toDouble() : null,
        circulatingSupply: (json["circulating_supply"] as num).toDouble(),
        totalSupply: json["total_supply"] != null ? (json["total_supply"] as num).toDouble() : null,
        maxSupply: json["max_supply"] != null ? (json["max_supply"] as num).toDouble() : null,
        ath: (json["ath"] as num).toDouble(),
        athChangePercentage: json["ath_change_percentage"] != null ? (json["ath_change_percentage"] as num).toDouble() : null,
        athDate: DateTime.parse(json["ath_date"]),
        atl: (json["atl"] as num).toDouble(),
        atlChangePercentage: json["atl_change_percentage"] != null ? (json["atl_change_percentage"] as num).toDouble() : null,
        atlDate: DateTime.parse(json["atl_date"]),
        roi: json["roi"] != null ? Roi.fromJson(json["roi"]) : null,
        lastUpdated: DateTime.parse(json["last_updated"]), 
        sparklineIn7D: json["sparkline_in_7d"] != null ? SparklineIn7D.fromJson(json["sparkline_in_7d"]) : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'fully_diluted_valuation': fullyDilutedValuation,
      'total_volume': totalVolume,
      'high_24h': high24H,
      'low_24h': low24H,
      'price_change_24h': priceChange24H,
      'price_change_percentage_24h': priceChangePercentage24H,
      'market_cap_change_24h': marketCapChange24H,
      'market_cap_change_percentage_24h': marketCapChangePercentage24H,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'max_supply': maxSupply,
      'ath': ath,
      'ath_change_percentage': athChangePercentage,
      'ath_date': athDate.toIso8601String(),
      'atl': atl,
      'atl_change_percentage': atlChangePercentage,
      'atl_date': atlDate.toIso8601String(),
      'roi': roi?.toJson(),
      'last_updated': lastUpdated.toIso8601String(),
      'sparkline_in_7d': sparklineIn7D?.toJson(),
    };
  }
}

class Roi {
  final double times;
  final String currency;
  final double percentage;

  Roi({required this.times, required this.currency, required this.percentage});

  factory Roi.fromJson(Map<String, dynamic> json) {
    return Roi(
      times: (json['times'] as num).toDouble(),
      currency: json['currency'] as String,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'times': times,
      'currency': currency,
      'percentage': percentage,
    };
  }
}


