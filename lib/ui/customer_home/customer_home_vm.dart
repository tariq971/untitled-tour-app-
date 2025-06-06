import 'package:get/get.dart';
import 'package:untitled/data/fav_repository.dart';
import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';

class CustomerHomeViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository=Get.find();
  CartItemRepository cartItemRepository= Get.find();
var cartItemCount=0.obs;
  @override
  void onInit() {
    super.onInit();
    loadCartCount();
  }
  void loadCartCount() {
    cartItemRepository.loadCartItemOfUser(authRepository.getLoggedInUser()!.uid).listen((data) {
      cartItemCount.value=data.length;
    });
  }
  
}


