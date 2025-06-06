import 'package:get/get.dart';
import 'package:untitled/data/order_repository.dart';
import 'package:untitled/data/shop_repository.dart';
import 'package:untitled/model/Order.dart';
import '../../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/fav_repository.dart';
import '../../data/fav_repository.dart';
import '../utils/Functions.dart';

class OrderViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  CartItemRepository cartItemRepository=Get.find();
  ShopRepository shopRepository=Get.find();
  OrderRepository orderRepository = Get.find();

  var isLoading = false.obs;
  var orderItems = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllOrderItems();
  }

  Future<void> loadAllOrderItems() async {
    if (Functions.isShop(authRepository.getLoggedInUser())) {
      orderRepository
          .loadOrderOfShop(authRepository.getLoggedInUser()!.uid)
          .listen((data) {
            orderItems.value = data;
          });
    }
    else {
      orderRepository
          .loadOrderOfUser(authRepository.getLoggedInUser()!.uid)
          .listen((data) {
            orderItems.value = data;
          });
    }
  }
}
