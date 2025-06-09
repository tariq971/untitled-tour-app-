import 'package:get/get.dart';
import '../../data/favourite_place_repo.dart';
import '../../model/favourite_place.dart';

class FavouritePlaceController extends GetxController {
  final FavouritePlaceRepository repository;

  FavouritePlaceController({required this.repository});

  var favourites = <FavouritePlace>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    loading.value = true;
    favourites.value = await repository.getFavourites();
    loading.value = false;
  }

  Future<void> addFavourite(FavouritePlace place) async {
    await repository.addFavourite(place);
    await loadFavourites();
  }

  Future<void> removeFavourite(String id) async {
    await repository.removeFavourite(id);
    await loadFavourites();
  }
}