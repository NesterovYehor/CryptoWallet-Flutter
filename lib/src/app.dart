import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/configs%20/injector/injector_conf.dart';
import 'package:crypto_track/src/core/theme/theme.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc_event.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc_state.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouteConf().router;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<ThemeBloc>()),
            BlocProvider(
              create: (context) =>
                  getIt<AuthBloc>()..add(const AuthCheckSignInStatusEvent()),
            ),
          ],
          child: BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) {
            return current.user != null;
          }, listener: (context, state) {
            if (state.isLoading) {
              router.goNamed(AppRoute.loading.name);
            } else if (state.user != null) {
              router.goNamed(AppRoute.market.name);
            } else if (state.user == null) {
              router.goNamed(AppRoute.login.name);
            }
          }, child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.data(state.isDarkMode),
                routerConfig: router,
              );
            },
          ))),
    );
  }
}
