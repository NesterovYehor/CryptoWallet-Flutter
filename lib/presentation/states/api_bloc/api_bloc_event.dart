part of 'api_bloc.dart';

sealed class ApiBlocEvent extends Equatable {
  const ApiBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchApiEvent extends ApiBlocEvent{}

class SearchCoinsEvent extends ApiBlocEvent {
  final String query;

  SearchCoinsEvent(this.query);
}