import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc_event.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:crypto_track/src/widgets/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Row(
                children: [
                  LogoWidget(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Text("CryptoTrack", style: AppFont.bold.s25)
                ],
              ),
            ],
          )),
          GestureDetector(
            onTap: () {
              context.push(AppRoute.settings.path);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.settings,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(context.loc.settings, style: AppFont.bold.s20)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child: Row(
              children: [
                Icon(
                  context.read<ThemeBloc>().state.isDarkMode
                      ? Icons.mode_night
                      : Icons.sunny,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(context.loc.themeMode, style: AppFont.bold.s20),
                const SizedBox(
                  width: 10,
                ),
                CupertinoSwitch(
                  value: context.watch<ThemeBloc>().state.isDarkMode,
                  onChanged: (value) {
                    if (value) {
                      context.read<ThemeBloc>().add(DarkThemeEvent());
                    } else {
                      context.read<ThemeBloc>().add(LightThemeEvent());
                    }
                  },
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.read<AuthBloc>().add(const AuthLogOutEvent()),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 50),
              child: Row(
                children: [
                  const Icon(
                    Icons.logout,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Logout", style: AppFont.bold.s20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
