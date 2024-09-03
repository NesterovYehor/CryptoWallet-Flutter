import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/configs%20/injector/injector_conf.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/core/utils/enums.dart';
import 'package:crypto_track/src/features/coins/presentation/state/bloc/coins_bloc.dart';
import 'package:crypto_track/src/features/market/presentation/bloc/market_bloc.dart';
import 'package:crypto_track/src/features/coins/presentation/widgets/coins_list.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:crypto_track/src/widgets/app_icon_btn.dart';
import 'package:crypto_track/src/features/market/presentation/widgets/market_statistics_widget.dart';
import 'package:crypto_track/src/widgets/error_widget.dart';
import 'package:crypto_track/src/widgets/loading_screen.dart';
import 'package:crypto_track/src/widgets/sidebar_menu.dart.dart';
import 'package:crypto_track/src/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarMenu(),
      appBar: _buildAppBar(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<MarketBloc>()..add(MarketFetchEvent()),
          ),
          BlocProvider(
            create: (context) => getIt<CoinsBloc>()..add(CoinFetchedEvent()),
          ),
        ],
        child: BlocConsumer<MarketBloc, MarketState>(
          listener: (context, state) {
            if(state is MarketFetchErrorState){
              appSnackBar(context, AppColor.redClr, state.errorMessage);
            }
          },
          builder: (context, state) {
            return BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) {
                if (state is MarketFetchingState) {
                  return const LoadingScreen();
                } else if (state is MarketFetchErrorState) {
                  return _buildFetchFailedState(state.errorMessage, context);
                } else if (state is MarketFetchedState) {
                  final coinState = context.watch<CoinsBloc>().state;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MarketStatisticsWidget(market: state.marketData),
                      coinListHeader(context),
                      if (coinState.status == DataStatus.failure) 
                        AppErrorWidget(context.loc.errorGenericFailure),
                      Expanded(
                          child: RefreshIndicator.adaptive(
                              onRefresh: () async {
                                context
                                    .read<MarketBloc>()
                                    .add(MarketFetchEvent());
                              },
                              child: const CoinsList()))
                    ],
                  );
                } else {
                  return AppErrorWidget(context.loc.errorGenericFailure);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFetchFailedState(String errorMessage, BuildContext context) {
    return Center(
      child: Text(context.loc.error(errorMessage)),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.loc.livePrices,
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
            onPressed: () => context.push(AppRoute.wallet.path),
            icon: Icons.arrow_forward_ios_sharp,
          ),
        ),
      ],
    );
  }

  Widget coinListHeader(BuildContext context) {
    final secondaryColor = AppColor.getSecondaryColor(
      context.select((ThemeBloc bloc) => bloc.state.isDarkMode),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          Text("Coin",
              style: AppFont.normal.s14.copyWith(color: secondaryColor)),
          const Spacer(),
          Text("Price",
              style: AppFont.normal.s14.copyWith(color: secondaryColor)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
