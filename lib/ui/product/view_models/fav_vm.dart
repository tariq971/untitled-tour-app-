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
  CartItemRepository cartItemRepository= Get.find();
  ShopRepository shopRepository =Get.find();
  var isSaving = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllProducts();
  }

  Future<void> loadAllProducts() async {
    var shops = await shopRepository.loadAllShopOnce();
    var productsMap = {for (var p in shops) p.id: p};
    productsRepository.loadAllProducts()
        .listen((data) {
          print("Products fetched: ${data.length}");
      products.value =
          data
              .map((e) {
            e.shopName=productsMap[e.uId]?.shopName??"";
            return e;
          })
              .toList();
    });

    // productsRepository.loadAllProducts().listen((data) {
    //   products.value = data;
    // });
  }
  void deleteProduct(Product product){
    productsRepository.deleteProduct(product);
  }

  void addToCart(Product product) {
    cartItemRepository.addCartItem(CartItem(product.id, authRepository.getLoggedInUser()!.uid, 1));
  }

}
