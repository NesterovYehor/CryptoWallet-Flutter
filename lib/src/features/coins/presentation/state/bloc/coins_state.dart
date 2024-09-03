part of 'coins_bloc.dart';


class CoinsState extends Equatable {
  const CoinsState({
    this.status = DataStatus.initial,
    this.coins = const <CoinEntity>[],
    this.hasReachedMax = false,
    this.isLoading = false,
    this.pageNumber = 1,}
  );

  final DataStatus status;
  final List<CoinEntity> coins;
  final bool hasReachedMax;
  final int pageNumber;
  final bool isLoading;

  CoinsState copyWith({
    DataStatus? status,
    List<CoinEntity>? coins,
    bool? hasReachedMax,
    int? pageNumber,
    bool? isLoading
  }) {
    return CoinsState(
      status: status ?? this.status,
      coins: coins ?? this.coins,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${coins.length} }''';
  }

  @override
  List<Object> get props => [status, coins, hasReachedMax];
}

