// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketModelImpl _$$MarketModelImplFromJson(Map<String, dynamic> json) =>
    _$MarketModelImpl(
      totalMarketCap: (json['total_market_cap']["usd"] as num).toDouble(),
      totalVolume: (json['total_volume']["usd"] as num).toDouble(),
      marketCapPercentage: (json['market_cap_change_percentage_24h_usd'] as num).toDouble() / 100,
      btcDominance: (json['market_cap_percentage']["btc"] as num).toDouble() / 100 ,
    );

Map<String, dynamic> _$$MarketModelImplToJson(_$MarketModelImpl instance) =>
    <String, dynamic>{
      'totalMarketCap': instance.totalMarketCap,
      'totalVolume': instance.totalVolume,
      'marketCapPercentage': instance.marketCapPercentage,
      'btcDominance': instance.btcDominance,
    };
