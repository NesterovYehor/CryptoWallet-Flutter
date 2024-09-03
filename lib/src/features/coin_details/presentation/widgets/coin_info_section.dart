import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/amount_input_field.dart';
import 'package:flutter/material.dart';

class CoinInfoSection extends StatelessWidget {
  final CoinEntity selectedCoin;
  final dynamic Function(String)? onChanged;
  final double value;
  const CoinInfoSection({
    super.key,
    required this.selectedCoin,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow(
          context: context,
          label: context.loc.currentPriceOf,
          value: context.loc.asCurrencyWith2Decimals(selectedCoin.currentPrice),
        ),
        _buildAmountInputRow(context: context),
        _buildInfoRow(
            context: context,
            label: context.loc.currentValue,
            value: context.loc.asCurrencyWith2Decimals(value)),
      ],
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFont.bold.s14,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            value,
            style: AppFont.bold.s14,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInputRow({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.loc.amountHolding,
          style: AppFont.bold.s14,
        ),
        const Spacer(),
        AmountInputField(
          onChanged: onChanged,
        ),
      ],
    );
  }
}
