import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final exception = Exception('An error occurred');
  group('AuthState', () {
    group('AuthStateUninitialized', () {
      test('supports value equality', () {
        expect(
          const AuthStateUninitialized(isLoading: false),
          const AuthStateUninitialized(isLoading: false),
        );
      });

      test('props are correct', () {
        expect(
          const AuthStateUninitialized(isLoading: false).props,
          [false, 'Please wait a moment'],
        );
      });
    });

    group('AuthStateLoading', () {
      test('supports value equality', () {
        expect(
          const AuthStateLoading(isLoading: true, loadingText: 'Loading...'),
          const AuthStateLoading(isLoading: true, loadingText: 'Loading...'),
        );
      });

      test('props are correct', () {
        expect(
          const AuthStateLoading(isLoading: true, loadingText: 'Loading...').props,
          [true, 'Loading...'],
        );
      });
    });

    group('AuthStateRegistering', () {
      test('supports value equality', () {
        expect(
          AuthStateRegistering(exception: exception, isLoading: true),
          AuthStateRegistering(exception: exception, isLoading: true),
        );
      });

      test('props are correct', () {
        expect(
          AuthStateRegistering(exception: exception, isLoading: true).props,
          [exception, true],
        );
      });
    });

    group('AuthStateLoggedOut', () {
      test('supports value equality', () {
        expect(
          AuthStateLoggedOut(exception: exception, isLoading: false),
          AuthStateLoggedOut(exception: exception, isLoading: false),
        );
      });

      test('props are correct', () {
        expect(
          AuthStateLoggedOut(exception: exception, isLoading: false).props,
          [exception, false],
        );
      });
    });
  });
}
