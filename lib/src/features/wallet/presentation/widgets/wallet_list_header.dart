import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCoinListHeader extends StatelessWidget {
  const WalletCoinListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final secondaryColor = AppColor.getSecondaryColor(
      context.select((ThemeBloc bloc) => bloc.state.isDarkMode),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          Text(
            "Coin",
            style: AppFont.normal.s14.copyWith(color: secondaryColor),
          ),
          const Spacer(),
          Text(
            context.loc.holdings,
            style: AppFont.normal.s14.copyWith(color: secondaryColor),
          ),
          const Spacer(),
          Text(
            context.loc.price,
            style: AppFont.normal.s14.copyWith(color: secondaryColor),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            child: Icon(
              Icons.replay,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
