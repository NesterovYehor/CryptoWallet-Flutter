import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/interfaces/firebase_repository.dart';

class AddCoinToPortfolio{
  final DbRepository repository;
  Future<void> call(PortfolioCoinModel portfolioCoin, String userId) async{
    return repository.addCoinToPortfolio(portfolioCoin, userId);
  }
  AddCoinToPortfolio({required this.repository});
}

class FetchPortfolioData{
  final DbRepository repository;
  Stream<List<PortfolioCoinModel>> call(String userId){
    return repository.fetchPortfolioData(userId);
  }
  FetchPortfolioData({required this.repository});
}

class DeleteCoinFromPortfolio{
  final DbRepository repository;
  Future<void> call(PortfolioCoinModel portfolioCoin, String userId){
    return repository.deleteCoinFromPortfolio(portfolioCoin, userId);
  }
  DeleteCoinFromPortfolio({required this.repository});
}