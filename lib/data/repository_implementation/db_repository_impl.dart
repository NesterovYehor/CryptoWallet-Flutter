import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/interfaces/firebase_repository.dart';

class DbRepositoryImpl implements DbRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addCoinToPortfolio(PortfolioCoinModel portfolioCoin, String userId) async {
  try {
    final coinDoc = db.collection("portfolio").doc(userId).collection("coins").doc(portfolioCoin.index);
    
    final existingCoinSnapshot = await coinDoc.get();
    if (existingCoinSnapshot.exists) {
      final existingAmount = existingCoinSnapshot.data()?['amount'] ?? 0.0;
      final newAmount = existingAmount + portfolioCoin.amount;
      await coinDoc.update({"amount": newAmount});
    } else {
      await coinDoc.set({
        "index": portfolioCoin.index,
        "amount": portfolioCoin.amount,
        "imageUrl": portfolioCoin.imageUrl
      });
    }
  } catch (e) {
    rethrow;
  }
}

  @override
  Stream<List<PortfolioCoinModel>> fetchPortfolioData(String userId) {
    final collectionRef = db.collection("portfolio").doc(userId).collection("coins");
    return collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PortfolioCoinModel.fromJson(doc.data());
      }).toList();
    });
  }
  
  @override
  Future<void> deleteCoinFromPortfolio(PortfolioCoinModel portfolioCoin, String userId) async {
    try {
      final coinDoc = db.collection("portfolio").doc(userId).collection("coins").doc(portfolioCoin.index);
      await coinDoc.delete();
    } catch (e) {
      rethrow;
    } 
  }
}
