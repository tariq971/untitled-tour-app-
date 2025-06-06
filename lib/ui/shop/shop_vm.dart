import 'package:get/get.dart';
import '../../../data/AuthRepository.dart';
import '../../data/fav_repository.dart';
import '../../data/shop_repository.dart';
import '../../model/Shop.dart';

class ShopViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  // CartItemRepository cartItemRepository=Get.find();
  ShopRepository shopRepository = Get.find();

  var isLoading = false.obs;
  var shopItems = <Shop>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllShopItems();
  }

  Future<void> loadAllShopItems() async {

      shopRepository
          .loadAllShop()
          .listen((data) {
            shopItems.value = data;
          });
    }

}
