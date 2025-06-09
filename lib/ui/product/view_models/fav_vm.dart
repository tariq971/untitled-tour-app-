import 'package:get/get.dart';
import 'package:untitled/data/shop_repository.dart';
import '../../../data/AuthRepository.dart';
import '../../../data/cart_repository.dart';
import '../../../data/fav_repository.dart';
import '../../../model/CartItem.dart';
import '../../../model/Fav.dart';

class ProductsViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  CartItemRepository cartItemRepository = Get.find();
  ShopRepository shopRepository = Get.find();
  var isSaving = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllProducts();
  }

  Future<void> loadAllProducts() async {
    try {
      var shops = await shopRepository.loadAllShopOnce();
      var productsMap = {for (var p in shops) p.id: p};

      productsRepository.loadAllProducts().listen(
            (data) {
          // If you want to add shopName to each product:
          // for (var product in data) {
          //   product.shopName = productsMap[product.uId]?.shopName ?? "";
          // }
          products.value = data; // <-- THIS is what makes products show up!
        },
        onError: (error) {
          print("Error loading products: $error");
          Get.snackbar("Error", "Failed to load Products: $error");
        },
      );
    } catch (e) {
      print("Error loading shop: $e");
      Get.snackbar("Error", "Failed to load shops: $e");
    }
  }

  void deleteProduct(Product product) {
    productsRepository.deleteProduct(product);
  }

  void addToCart(Product product) {
    cartItemRepository.addCartItem(
      CartItem(product.id, authRepository.getLoggedInUser()!.uid, 1),
    );
  }
}