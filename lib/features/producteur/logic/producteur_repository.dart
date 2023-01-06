import 'package:sigi_android/common/platform/connectivity_manager.dart';
import '../data/producteur/producteur_local_data_provider.dart';
import '../data/producteur/producteur_model.dart';
import '../data/producteur/producteur_remote_data_provider.dart';

class ProducteurRepository {
  ProducteurRepository(
    this.producteurLocalDataProvider,
    this.producteurRemoteDataProvider,
  );

  final ProducteurLocalDataProvider producteurLocalDataProvider;
  final ProducteurRemoteDataProvider producteurRemoteDataProvider;

  Future<List<Producteur>?>? fetchProducteurs() async {
    if (await ConnectivityManager.isConnected) {
      try {
        final List<Producteur>? producteurs =
            await producteurRemoteDataProvider.fetchProducteurs();
        producteurLocalDataProvider.cacheProducteurs(producteurs);
        return producteurs;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return producteurLocalDataProvider.fetchProducteurs();
    }
  }

  Future<Producteur?> getProducteur(String id) async {
    if (await ConnectivityManager.isConnected) {
      try {
        final Producteur? producteur =
            await producteurRemoteDataProvider.getProducteur(id);
        // cache product
        producteurLocalDataProvider.cacheProducteur(producteur);
        return producteur;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return producteurLocalDataProvider.getProducteur(id);
    }
  }
}
