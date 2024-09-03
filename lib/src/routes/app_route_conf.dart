import 'package:crypto_track/src/features/authentication/presentation/screens/log_in_screen.dart';
import 'package:crypto_track/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:crypto_track/src/features/coin_details/presentation/screens/detail_screen.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/market/presentation/screens/market_screen.dart';
import 'package:crypto_track/src/features/settings/screens/settings_screen.dart';
import 'package:crypto_track/src/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:crypto_track/src/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouteConf{

  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.login.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: AppRoute.loading.name,
        path: AppRoute.loading.path,
        pageBuilder: (context, state) => customSlidableTransition(context, state, const LoadingScreen()),
      ),
      GoRoute(
        name: AppRoute.login.name,
        path: AppRoute.login.path,
        pageBuilder: (context, state) => customResizableTransition(context, state, const LogInScreen()),
      ),
      GoRoute(
        name: AppRoute.register.name,
        path: AppRoute.register.path,
        pageBuilder: (context, state) => customResizableTransition(context, state, const RegisterScreen()),
      ),
      GoRoute(
        name: AppRoute.market.name,
        path: AppRoute.market.path,
        pageBuilder: (context, state) => customSlidableTransition(context, state, const MarketScreen()),
      ),
      GoRoute(
        name: AppRoute.wallet.name,
        path: AppRoute.wallet.path,
        pageBuilder: (context, state) => customSlidableTransition(context, state, const WalletScreen()),
      ),
      GoRoute(
        name: AppRoute.details.name,
        path: AppRoute.details.path,
        pageBuilder: (context, state) =>
            customResizableTransition(context, state, DetailScreen(coin: state.extra as CoinEntity)),
      ),
      GoRoute(
        name: AppRoute.settings.name,
        path: AppRoute.settings.path,
        pageBuilder: (context, state) =>
            customSlidableTransition(context, state, SettingsScreen()),
      ),
    ],
  ); 
}


Page<void> customSlidableTransition(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Page<void> customResizableTransition(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.ease;

      var tween =
          Tween<double>(begin: begin, end: end).chain(CurveTween(curve: curve));
      var scaleAnimation = animation.drive(tween);

      return ScaleTransition(
        scale: scaleAnimation,
        alignment: Alignment.bottomCenter,
        child: child,
      );
    },
  );
}