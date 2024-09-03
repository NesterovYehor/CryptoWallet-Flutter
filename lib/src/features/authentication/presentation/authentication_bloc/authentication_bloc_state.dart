import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:crypto_track/src/features/authentication/domain/entities/user_entitie.dart';

part 'authentication_bloc_state.freezed.dart'; // Ensure this line is present and correct

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(true) bool isLoading,
    String? error,
    UserEntity? user,
  }) = _AuthState;
}
