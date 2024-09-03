import 'package:bloc/bloc.dart';
import 'package:crypto_track/src/core/utils/logger.dart';
import '../../domain/use_cases/auth_use_cases.dart';
import '../../domain/use_cases/check_signin_status_usecase.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/logout_usecase.dart';
import '../../domain/use_cases/register_usecase.dart';
import 'authentication_bloc_event.dart';
import 'authentication_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase _logInUseCase;
  final AuthRegisterUseCase _registerUseCase;
  final AuthLogoutUseCase _logOutUseCase;
  final AuthCheckSignInStatusUseCase _checkSignInStatusUseCase;

  AuthBloc(
    this._logInUseCase,
    this._registerUseCase,
    this._logOutUseCase,
    this._checkSignInStatusUseCase,
  ) : super(const AuthState(isLoading: true)) {
    on<AuthCheckSignInStatusEvent>(_checkSignInStatus);
    on<AuthLogInEvent>(_onLogIn);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogOutEvent>(_onLogOut);
  }

  _checkSignInStatus(AuthCheckSignInStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _checkSignInStatusUseCase.call();
      // logger.e(user);
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  _onLogIn(AuthLogInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final params = LoginParams(email: event.email, password: event.password);
      final user = await _logInUseCase.call(params);
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final params = RegisterParams(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      await _registerUseCase.call(params);
      add(const AuthCheckSignInStatusEvent());
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  _onLogOut(AuthLogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _logOutUseCase.call();
      emit(state.copyWith(user: null, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
