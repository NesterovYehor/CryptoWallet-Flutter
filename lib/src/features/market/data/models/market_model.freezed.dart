// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarketModel _$MarketModelFromJson(Map<String, dynamic> json) {
  return _MarketModel.fromJson(json);
}

/// @nodoc
mixin _$MarketModel {
  double get totalMarketCap => throw _privateConstructorUsedError;
  double get totalVolume => throw _privateConstructorUsedError;
  double get marketCapPercentage => throw _privateConstructorUsedError;
  double get btcDominance => throw _privateConstructorUsedError;

  /// Serializes this MarketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketModelCopyWith<MarketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketModelCopyWith<$Res> {
  factory $MarketModelCopyWith(
          MarketModel value, $Res Function(MarketModel) then) =
      _$MarketModelCopyWithImpl<$Res, MarketModel>;
  @useResult
  $Res call(
      {double totalMarketCap,
      double totalVolume,
      double marketCapPercentage,
      double btcDominance});
}

/// @nodoc
class _$MarketModelCopyWithImpl<$Res, $Val extends MarketModel>
    implements $MarketModelCopyWith<$Res> {
  _$MarketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMarketCap = null,
    Object? totalVolume = null,
    Object? marketCapPercentage = null,
    Object? btcDominance = null,
  }) {
    return _then(_value.copyWith(
      totalMarketCap: null == totalMarketCap
          ? _value.totalMarketCap
          : totalMarketCap // ignore: cast_nullable_to_non_nullable
              as double,
      totalVolume: null == totalVolume
          ? _value.totalVolume
          : totalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      marketCapPercentage: null == marketCapPercentage
          ? _value.marketCapPercentage
          : marketCapPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      btcDominance: null == btcDominance
          ? _value.btcDominance
          : btcDominance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketModelImplCopyWith<$Res>
    implements $MarketModelCopyWith<$Res> {
  factory _$$MarketModelImplCopyWith(
          _$MarketModelImpl value, $Res Function(_$MarketModelImpl) then) =
      __$$MarketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalMarketCap,
      double totalVolume,
      double marketCapPercentage,
      double btcDominance});
}

/// @nodoc
class __$$MarketModelImplCopyWithImpl<$Res>
    extends _$MarketModelCopyWithImpl<$Res, _$MarketModelImpl>
    implements _$$MarketModelImplCopyWith<$Res> {
  __$$MarketModelImplCopyWithImpl(
      _$MarketModelImpl _value, $Res Function(_$MarketModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMarketCap = null,
    Object? totalVolume = null,
    Object? marketCapPercentage = null,
    Object? btcDominance = null,
  }) {
    return _then(_$MarketModelImpl(
      totalMarketCap: null == totalMarketCap
          ? _value.totalMarketCap
          : totalMarketCap // ignore: cast_nullable_to_non_nullable
              as double,
      totalVolume: null == totalVolume
          ? _value.totalVolume
          : totalVolume // ignore: cast_nullable_to_non_nullable
              as double,
      marketCapPercentage: null == marketCapPercentage
          ? _value.marketCapPercentage
          : marketCapPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      btcDominance: null == btcDominance
          ? _value.btcDominance
          : btcDominance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketModelImpl implements _MarketModel {
  _$MarketModelImpl(
      {required this.totalMarketCap,
      required this.totalVolume,
      required this.marketCapPercentage,
      required this.btcDominance});

  factory _$MarketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketModelImplFromJson(json);

  @override
  final double totalMarketCap;
  @override
  final double totalVolume;
  @override
  final double marketCapPercentage;
  @override
  final double btcDominance;

  @override
  String toString() {
    return 'MarketModel(totalMarketCap: $totalMarketCap, totalVolume: $totalVolume, marketCapPercentage: $marketCapPercentage, btcDominance: $btcDominance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketModelImpl &&
            (identical(other.totalMarketCap, totalMarketCap) ||
                other.totalMarketCap == totalMarketCap) &&
            (identical(other.totalVolume, totalVolume) ||
                other.totalVolume == totalVolume) &&
            (identical(other.marketCapPercentage, marketCapPercentage) ||
                other.marketCapPercentage == marketCapPercentage) &&
            (identical(other.btcDominance, btcDominance) ||
                other.btcDominance == btcDominance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalMarketCap, totalVolume,
      marketCapPercentage, btcDominance);

  /// Create a copy of MarketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketModelImplCopyWith<_$MarketModelImpl> get copyWith =>
      __$$MarketModelImplCopyWithImpl<_$MarketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketModelImplToJson(
      this,
    );
  }
}

abstract class _MarketModel implements MarketModel {
  factory _MarketModel(
      {required final double totalMarketCap,
      required final double totalVolume,
      required final double marketCapPercentage,
      required final double btcDominance}) = _$MarketModelImpl;

  factory _MarketModel.fromJson(Map<String, dynamic> json) =
      _$MarketModelImpl.fromJson;

  @override
  double get totalMarketCap;
  @override
  double get totalVolume;
  @override
  double get marketCapPercentage;
  @override
  double get btcDominance;

  /// Create a copy of MarketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketModelImplCopyWith<_$MarketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
