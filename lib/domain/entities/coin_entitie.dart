class Coin {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice; 
  double marketCap; 
  int marketCapRank;
  double? fullyDilutedValuation; 
  double totalVolume; 
  double high24H; 
  double low24H; 
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? marketCapChange24H; 
  double? marketCapChangePercentage24H;
  double circulatingSupply; 
  double? totalSupply; 
  double? maxSupply; 
  double ath; 
  double? athChangePercentage;
  DateTime athDate;
  double atl;
  double? atlChangePercentage;
  DateTime atlDate;
  dynamic roi;
  DateTime lastUpdated;
  SparklineIn7D? sparklineIn7D;


  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
    required this.sparklineIn7D
  });
}


class SparklineIn7D {
  final List<double> price;
  
  SparklineIn7D({required this.price});
  
  factory SparklineIn7D.fromJson(Map<String, dynamic> json) {
    return SparklineIn7D(
      price: List<double>.from(json['price'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': List<dynamic>.from(price.map((x) => x)),
    };
  }
}