import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const email = 'test@example.com';
  const password = 'password123';

  group("AuthEvent", () {
    group("AuthEventInitialize", () {
      test("supports value equality", () {
        expect(
          const AuthEventInitialize(),
          const AuthEventInitialize(),
        );
      });

      test("props are correct", () {
        expect(
          const AuthEventInitialize().props,
          <Object?>[],
        );
      });
    });

    group("AuthEventLogIn", () {
      test("supports value equality", () {
        expect(
          const AuthEventLogIn(email, password),
          const AuthEventLogIn(email, password),
        );
      });

      test("props are correct", () {
        expect(
          const AuthEventLogIn(email, password).props,
          [email, password],
        );
      });
    });

    group("AuthEventRegister", () {
      test("supports value equality", () {
        expect(
          const AuthEventRegister(email, password),
          const AuthEventRegister(email, password),
        );
      });

      test("props are correct", () {
        expect(
          const AuthEventRegister(email, password).props,
          [email, password],
        );
      });
    });

    group("AuthEventLogOut", () {
      test("supports value equality", () {
        expect(
          const AuthEventLogOut(),
          const AuthEventLogOut(),
        );
      });

      test("props are correct", () {
        expect(
          const AuthEventLogOut().props,
          <Object?>[],
        );
      });
    });
  });
}
