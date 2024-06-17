import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/interfaces/firebase_repository.dart';

class DbRepositoryImpl extends DbRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addCoinToPortfolio(PortfolioCoinModel portfolioCoinModel, String userId) async {
  try {
    final coinDoc = db.collection("portfolio").doc(userId).collection("coins").doc(portfolioCoinModel.index);
    
    final existingCoinSnapshot = await coinDoc.get();
    if (existingCoinSnapshot.exists) {
      final existingAmount = existingCoinSnapshot.data()?['amount'] ?? 0.0;
      final newAmount = existingAmount + portfolioCoinModel.amount;
      await coinDoc.update({"amount": newAmount});
    } else {
      // If the coin doesn't exist, add a new entry
      await coinDoc.set({
        "index": portfolioCoinModel.index,
        "amount": portfolioCoinModel.amount,
        "imageUrl": portfolioCoinModel.imageUrl
      });
    }
  } catch (e) {
    print("Error adding coin to portfolio: $e");
    throw e;
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
}
