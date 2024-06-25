part of 'api_bloc.dart';

sealed class ApiBlocEvent extends Equatable {
  const ApiBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchApiEvent extends ApiBlocEvent{}

class SortCoinsByPriceEvent extends ApiBlocEvent {}

