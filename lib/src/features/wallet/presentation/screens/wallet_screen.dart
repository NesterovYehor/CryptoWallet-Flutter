import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coin_details/presentation/state/add_coin_form/add_coin_form_bloc.dart';
import 'package:crypto_track/src/features/coins/presentation/widgets/coin_list_tile_widget.dart';
import 'package:crypto_track/src/features/wallet/presentation/widgets/wallet_list_header.dart';
import 'package:crypto_track/src/widgets/error_widget.dart';
import 'package:crypto_track/src/widgets/sidebar_menu.dart.dart';
import 'package:crypto_track/src/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:crypto_track/src/configs%20/injector/injector_conf.dart';
import 'package:crypto_track/src/core/utils/enums.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/features/coin_details/presentation/screens/detail_screen.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coins/presentation/state/bloc/coins_bloc.dart';
import 'package:crypto_track/src/features/wallet/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:crypto_track/src/features/wallet/presentation/widgets/wallet_summary_widget.dart';
import 'package:crypto_track/src/widgets/app_icon_btn.dart';
import 'package:crypto_track/src/widgets/loading_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarMenu(),
      appBar: _buildAppBar(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<WalletBloc>()
              ..add(WalletFetchDataEvent(
                userId: context.read<AuthBloc>().state.user?.userId ?? "",
              )),
          ),
          BlocProvider(
            create: (_) => getIt<CoinsBloc>(),
          ),
          BlocProvider(create: (_) => getIt<AddCoinFormBloc>())
        ],
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            if (walletState is WalletFetchingState) {
              return const LoadingScreen();
            } else if (walletState is WalletErrorState) {
              appSnackBar(context, AppColor.redClr, walletState.errorMessage);
              return AppErrorWidget(walletState.errorMessage);
            } else if (walletState is WalletFetchedState) {
              return BlocBuilder<CoinsBloc, CoinsState>(
                builder: (context, coinsState) {
                  if (coinsState.status == DataStatus.success) {
                    return _buildDataFetchedState(
                        context, walletState, coinsState.coins);
                  } else {
                    return Center(child: Text(context.loc.errorGenericFailure));
                  }
                },
              );
            } else {
              return Center(child: Text(context.loc.errorGenericFailure));
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.loc.wallet,
        style: AppFont.bold.s20,
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) {
            return AppIconBtn(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icons.info_outlined,
            );
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppIconBtn(
            onPressed: () => context.pop(),
            icon: Icons.arrow_back_ios_new,
          ),
        ),
      ],
    );
  }

  Widget _buildDataFetchedState(
    BuildContext context,
    WalletFetchedState walletState,
    List<CoinEntity> coins,
  ) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<WalletBloc>().add(WalletFetchDataEvent(
            userId: context.read<AuthBloc>().state.user?.userId ?? ""));
      },
      child: Column(
        children: [
          WalletSummaryWidget(
              walletCoins: walletState.walletCoins, coins: coins),
          const WalletCoinListHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: walletState.walletCoins.length,
              itemBuilder: (context, index) {
                final walletCoin = walletState.walletCoins[index];
                final coin = coins.firstWhere((c) => c.id == walletCoin.id);
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(coin: coin)),
                  ),
                  child: CoinListTileWidget(
                    showChart: false,
                    coin: coin,
                    amount: walletCoin.amount,
                    slideAction: (context) => context.read<WalletBloc>().add(
                        WalletDeleteCoinEvent(
                            coinId: coin.id,
                            userId:
                                context.read<AuthBloc>().state.user?.userId ??
                                    "")),
                    isSlidable: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
