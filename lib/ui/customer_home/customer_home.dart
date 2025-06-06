import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/fav_repository.dart';
import 'package:untitled/ui/cart/cart_vm.dart';
import 'package:untitled/ui/product/fav.dart';
import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../cart/cart.dart';
import '../order/order.dart';
import '../shop/shop.dart';
import 'customer_home_vm.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentPage = 0;
  late CustomerHomeViewModel customerHomeViewModel;
  @override
  void initState() {
    super.initState();
    customerHomeViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: "Products",
            activeIcon: Icon(Icons.cake),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined),
            label: "Shops",
            activeIcon: Icon(Icons.shopping_basket),
          ),
          BottomNavigationBarItem(
            icon: Obx(
              () => Badge(
                label: Text(
                  customerHomeViewModel.cartItemCount.value.toString(),
                ),

                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
            label: "Carts",
            activeIcon: Obx(
              () => Badge(
                label: Text(
                  customerHomeViewModel.cartItemCount.value.toString(),
                ),
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Orders",
            activeIcon: Icon(Icons.shopping_bag),
          ),
        ],
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.blueAccent,
      ),
      body: getPage(currentPage),
    );
  }

  Widget getPage(int currentPage) {
    if (currentPage == 0) {
      ProductsBinding().dependencies();
      return ProductPage();
    }
    if (currentPage == 1) {
      ShopBinding().dependencies();
      return ShopPage();
    }
    if (currentPage == 2) {
      CartBinding().dependencies();
      return CartPage();
    }
    if (currentPage == 3) {
      OrderBinding().dependencies();
      return OrderPage();
    }
    return Placeholder();
  }
}

class CustomerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(CartItemRepository());
    Get.put(ProductsRepository());
    Get.put(CustomerHomeViewModel());
  }
}
