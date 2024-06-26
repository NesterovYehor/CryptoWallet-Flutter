import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/db_bloc/db_bloc.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_text_btn.dart';
import 'package:crypto_track/presentation/widgets/coin_row_tile_widget.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class EditPortfolioScreen extends StatefulWidget {
  EditPortfolioScreen({super.key, required this.selectedCoin});

  CoinModel? selectedCoin;

  @override
  State<EditPortfolioScreen> createState() => _EditPortfolioScreenState();
}

class _EditPortfolioScreenState extends State<EditPortfolioScreen> {
  final TextEditingController searchBar = TextEditingController();
  final TextEditingController amount = TextEditingController();

  @override
  void dispose() {
    searchBar.dispose();
    amount.dispose();
    super.dispose();
  }

  String calculateCurrentValue() {
    if (amount.text.isEmpty || widget.selectedCoin == null) return "0.0";
    double amountHolding = double.tryParse(amount.text) ?? 0.0;
    return (widget.selectedCoin!.currentPrice * amountHolding).asCurrencyWith2Decimals();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width * 0.09,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(35)
                ),
              )
            ],
          ),
          Text(
            "Edit Portfolio",
            style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          AppInputField(
            controller: searchBar,
            hint: "Search by name or symbol...",
            title: "",
            obscureText: false,
            icon: Icons.search, onChanged: (value) {  },
          ),
          const SizedBox(height: 10,),
          BlocBuilder<ApiBloc, ApiBlocState>(
            builder: (context, state) {
              if (state is FetchingFailedState) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              } else if (state is FetchingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ApiFetchedState) {
                final coins = state.coins;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: coins.length,
                          itemBuilder: (context, index) {
                            final coin = coins[index];
                            return GestureDetector(
                              onTap: () => setState(() {
                                widget.selectedCoin = coin;
                              }),
                              child: CoinRowTileWidget(
                                coin: coin,
                                isSelected: widget.selectedCoin == coin,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          ),
          if (widget.selectedCoin != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: _coinHoldingInfo()
            ),
          const Spacer(),
          AppTextBtn(
            color: widget.selectedCoin != null && amount.text.isNotEmpty ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
            lable: "Add to Portfolio",
            onTap: () {
              if (widget.selectedCoin != null && amount.text.isNotEmpty) {
                double? amountValue = double.tryParse(amount.text);
                if (amountValue != null) {
                  context.read<DbBloc>().add(PushDataEvent(
                    portfolioCoin: PortfolioCoinModel(
                      amount: amountValue,
                      imageUrl: widget.selectedCoin!.image,
                      index: widget.selectedCoin!.symbol,
                    ),
                  ));
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _coinHoldingInfo(){
    return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current price of",  style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      widget.selectedCoin!.currentPrice.asCurrencyWith2Decimals(), 
                      style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount holding", style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        hintText: "Ex: 1.4",
                        hintStyle: titleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.background,
                            width: 0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.background,
                            width: 0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current value", style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      calculateCurrentValue(),
                      style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary)
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
