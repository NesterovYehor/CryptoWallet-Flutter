import 'dart:async';
import 'package:async/async.dart';
import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/presentation/screens/auth/log_in_screen.dart';
import 'package:crypto_track/presentation/screens/auth/sign_up_screen.dart';
import 'package:crypto_track/presentation/screens/detail/detail_screen.dart';
import 'package:crypto_track/presentation/screens/home/home_screen.dart';
import 'package:crypto_track/presentation/screens/portfolio/portfolio_screen.dart';
import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAppWithRouter extends StatelessWidget {
  const MyAppWithRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticationBloc>();
    authBloc.add(const AuthEventInitialize());

    final GoRouter router = GoRouter(
      refreshListenable: GoRouterRefreshStream(
        StreamGroup.merge([authBloc.stream]),
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final coin = state.extra as CoinModel;
            return DetailScreen(coin: coin);
          },
        ),
        GoRoute(
          path: '/logIn',
          builder: (context, state) => const LogInScreen(),
        ),
        GoRoute(
          path: '/signUp',
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const PortfolioScreen(),
        ),
      ],
      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoggedIn = authState is AuthStateLoggedIn;
        final isLoggingIn = state.uri.toString() == '/logIn' || state.uri.toString() == '/signUp';

        if (!isLoggedIn && !isLoggingIn) return '/logIn';
        if (isLoggedIn && isLoggingIn) return '/';

        return null;
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<void> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
