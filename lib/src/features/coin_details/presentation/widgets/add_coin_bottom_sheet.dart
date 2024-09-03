import 'package:crypto_track/src/configs%20/injector/injector_conf.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/src/features/coin_details/presentation/state/add_coin_form/add_coin_form_bloc.dart';
import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/features/wallet/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/bottom_sheet_handle.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/coin_info_section.dart';
import 'package:crypto_track/src/widgets/app_btn.dart';
import 'package:go_router/go_router.dart';

class AddCoinBottomSheet extends StatelessWidget {
  const AddCoinBottomSheet({super.key, required this.coin});

  final CoinEntity coin;

  static const double defaultSpacing = 20.0; 

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthBloc>().state.user?.userId ?? "";
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddCoinFormBloc(),
        ),
        BlocProvider(
          create: (context) => getIt<WalletBloc>(),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 15,
          right: 15,
          top: 15,
        ),
        child: BlocBuilder<AddCoinFormBloc, AddCoinFormState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BottomSheetHandle(),
                const SizedBox(height: defaultSpacing),
                CoinInfoSection(
                  selectedCoin: coin,
                  value: state.price,
                  onChanged: (amount) {
                    context.read<AddCoinFormBloc>().add(
                          CoinAmountChangedEvent(
                            amount: double.tryParse(amount) ?? 0.0,
                            price: coin.currentPrice,
                          ),
                        );
                  },
                ),
                const SizedBox(height: defaultSpacing),
                _buildAddToWalletBtn(
                  context,
                  coin,
                  state.amount.toString(),
                  userId,
                  state.price,
                ),
                const SizedBox(height: defaultSpacing),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddToWalletBtn(
    BuildContext context,
    CoinEntity newCoin,
    String amount,
    String userId,
    double investmentValue,
  ) {
    final bool isEnabled = amount.isNotEmpty;
    return Row(
      children: [
        Expanded(
          child: AppBtn(
            label: context.loc.addToWallet,
            onTap: () {
              if (isEnabled) {
                final double? amountValue = double.tryParse(amount);
                if (amountValue != null) {
                  context.read<WalletBloc>().add(
                        WalletAddCoinEvent(
                          newCoin: WalletCoinEntity(
                            amount: amountValue,
                            imageUrl: newCoin.image,
                            id: newCoin.id,
                            investmentValue: investmentValue,
                          ),
                          userId: userId,
                        ),
                      );
                  context.pop();
                } else {
                  // Optionally show a message if parsing fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.loc.invalidAmount)),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
