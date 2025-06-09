import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/fav_repository.dart';
import 'package:untitled/ui/cart/cart_vm.dart';
import 'package:untitled/ui/product/fav.dart';
import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../cart/cart.dart';
import '../favourite/favourite_place_page.dart';
import '../order/order.dart';
import '../profile/user_controller.dart';
import '../shop/shop.dart';
import 'customer_home_vm.dart';
 import 'package:untitled/ui/profile/profile_icon.dart';


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
    // final userController = Get.find<UserController>();

  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      extendBody: true,

      // Custom App Bar
      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(110),
        child: Container(
          height: 110,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff43cea2), Color(0xff185a9d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.teal, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Welcome, Customer!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Explore amazing places and deals.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => ProfileIcon(
                    imageUrl: userController.avatarUrl.value,
                    initials: userController.initials,
                    radius: 28,
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  )),
                  // Profile icon
                  // ProfileIcon(
                  //   imageUrl: "", // Replace with your user's photo URL if any
                  //   initials: "JD", // Use user's initials if no photo
                  //   radius: 28,
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/profile');
                  //   },
                  // ),
                  const SizedBox(width: 10),
                  // Admin Login button
                  ElevatedButton.icon(
                    onPressed: () => Get.offAllNamed('/login', arguments: {'from': 'admin'}),
                    icon: const Icon(Icons.admin_panel_settings),
                    label: const Text("Admin Login"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(10, 38),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Page Body
      body: Container(
          color: Colors.grey[100],
          child: getPage(currentPage),
        ),


      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: currentPage,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.blueGrey,
            showUnselectedLabels: true,
            onTap: (value) {
              setState(() {
                currentPage = value;
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore, color: Colors.teal),
                label: "Products",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined),
                activeIcon: Icon(Icons.storefront, color: Colors.teal),
                label: "Shops",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite, color: Colors.teal),
                label: "Favourite",
              ),
              BottomNavigationBarItem(
                icon: Obx(() => Badge(
                  label: Text(
                    customerHomeViewModel.cartItemCount.value.toString(),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                )),
                activeIcon: Obx(() => Badge(
                  label: Text(
                    customerHomeViewModel.cartItemCount.value.toString(),
                  ),
                  child: const Icon(Icons.shopping_cart, color: Colors.teal),
                )),
                label: "Carts",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long, color: Colors.teal),
                label: "Orders",
              ),
            ],
          ),
        ),
      ),
    );
  }

  final userController = Get.find<UserController>();



  // Navigation Pages
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
      return FavouritePlacesPage(); // <-- Add this!
    }

    if (currentPage == 3) {
      CartBinding().dependencies();
      return CartPage();
    }
    if (currentPage == 4) {
      OrderBinding().dependencies();
      return OrderPage();
    }
    return const Placeholder();
  }
}

// Bindings for dependency injection
class CustomerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(CartItemRepository());
    Get.put(ProductsRepository());
    Get.put(UserController());
    Get.put(CustomerHomeViewModel());
  }
}
