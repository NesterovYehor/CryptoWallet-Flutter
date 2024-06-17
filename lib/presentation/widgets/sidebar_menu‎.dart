import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/presentation/widgets/logo_image.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    LogoWidget(width: MediaQuery.of(context).size.width * 0.2,),
                    Text("CryptoTrack", style:  headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),)
                  ],
                ),
                Divider(color: Theme.of(context).colorScheme.secondary, thickness: 0.3,),
              ],
            )
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Icon(Icons.settings, color: Theme.of(context).colorScheme.primary,),
                  const SizedBox(width: 10,),
                  Text("Settings", style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                ],
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => context.read<AuthenticationBloc>().add(const AuthEventLogOut()),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 50),
              child: Row(
                children: [
                  Icon(Icons.logout, color: Theme.of(context).colorScheme.primary,),
                  const SizedBox(width: 10,),
                  Text("Logout", style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}