import 'package:cloud_firestore/cloud_firestore.dart';

class ApiUrl {
  const ApiUrl._();

  static const baseCoinsUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true";
  static const baseMarketUrl = "https://api.coingecko.com/api/v3/global?vs_currency=usd&x_cg_demo_api_key=CG-UKmWUafngVfdHFFXSPrWTar9";

  static final wallets = FirebaseFirestore.instance.collection("wallets");
  static final users = FirebaseFirestore.instance.collection("users");
}
