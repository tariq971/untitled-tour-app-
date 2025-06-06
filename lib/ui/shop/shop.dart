import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/AuthRepository.dart';
import '../../data/fav_repository.dart';
import '../../data/shop_repository.dart';
import '../../model/Shop.dart';
import 'shop_vm.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late ShopViewModel shopViewModel;

  @override
  void initState() {
    super.initState();
    shopViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: shopViewModel.shopItems.length,
                itemBuilder: (context, index) {
                  Shop shop =
                      shopViewModel.shopItems[index];
                  return ListTile(
                    onLongPress: () {
                      Get.dialog(
                        AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // TextButton(
                              //   child: const Text('Delete'),
                              //   onPressed: () {
                              //     Get.back();
                              //     shopViewModel.deleteShopItem(
                              //       shopItemWithProduct.shopItem,
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: Text(shop.shopName),


                    subtitle: Column(
                      children: [
                        Text("Category. ${shop.category}"),

                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        );
      }),
    );
  }
}

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ShopRepository());
    Get.put(ProductsRepository());
    Get.put(ShopViewModel());
  }
}
