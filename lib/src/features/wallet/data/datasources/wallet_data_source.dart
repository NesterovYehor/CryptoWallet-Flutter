import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_track/src/core/api/api_url.dart';
import 'package:crypto_track/src/core/utils/logger.dart';
import 'package:crypto_track/src/features/wallet/data/models/wallet_coin_model.dart';

sealed class WalletRemoteDataSource {
  Future<List<WalletCoinModel>> fetchWalletData(String userId);
  Future<void> addCoinToWallet(String userId, WalletCoinModel newCoin);
  Future<void> deleteFromWallet(String userId,  String coinId);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  @override
  Future<List<WalletCoinModel>> fetchWalletData(String userId) async {
    try {
      final collectionRef = ApiUrl.wallets.doc(userId).collection("coins");
      final snapshot = await collectionRef.get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>; // Ensure this is a Map<String, dynamic>
        return WalletCoinModel.fromJson(data);
      }).toList();
    } catch (e) {
      logger.e("Failed to fetch wallet data: $e");
      throw Exception("Failed to fetch wallet data: $e");
    }
  }

  @override
  Future<void> addCoinToWallet(String userId, WalletCoinModel newCoin) async {
    try {
      final coinDocRef = ApiUrl.wallets.doc(userId).collection("coins").doc(newCoin.id);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final coinDoc = await transaction.get(coinDocRef);
        if (coinDoc.exists) {
          // Document exists, update the amount
          final currentAmount = (coinDoc.data()?['amount'] as num?)?.toDouble() ?? 0.0;
          final newAmount = currentAmount + newCoin.amount;
          transaction.update(coinDocRef, {'amount': newAmount});
        } else {
          // Document does not exist, create a new one with the initial amount
          transaction.set(coinDocRef, newCoin.toJson());
        }
      });
    } catch (e) {
      logger.e("Failed to add coin to wallet: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteFromWallet(String userId, String coinId) async {
    try {
      final coinDocRef = ApiUrl.wallets.doc(userId).collection("coins").doc(coinId);
      await coinDocRef.delete();
    } catch (e) {
      logger.e("Failed to delete coin from wallet: $e");
      rethrow;
    }
  }
}
