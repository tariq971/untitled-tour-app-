import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/shop_repository.dart';
import 'package:untitled/ui/product/view_models/fav_vm.dart';
import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../data/fav_repository.dart';
import '../../model/Fav.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductsViewModel productsViewModel;

  @override
  void initState() {
    super.initState();
    productsViewModel = Get.find();
    productsViewModel.loadAllProducts(); // <--- ADD THIS LINE
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tour Places"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed('/addProduct');
          if (result == true) {
            Get.snackbar("Product saved", "Product saved successfully");
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        print("Products length: ${productsViewModel.products.length}"); // <--- ADD HERE

        return ListView.builder(

          itemCount: productsViewModel.products.length,
          itemBuilder: (context, index) {
            Product product = productsViewModel.products[index];

            return ListTile(
              onLongPress: () {
                Get.dialog(
                  AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          child: const Text('Edit'),
                          onPressed: () {
                            Get.back();
                            Get.toNamed('/addProduct', arguments: product);
                          },
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            Get.back();
                            productsViewModel.deleteProduct(product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              leading: product.image == null
                  ? const Icon(Icons.image, size: 80)
                  : Image.network(
                product.image!,
                height: 80,
                width: 80,
              ),
              trailing: TextButton(
                onPressed: () {
                  productsViewModel.addToCart(product);
                },
                child: const Text("Add to cart"),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.placeName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.rent.toString()),
                  Text('Days: ${product.days}'),
                  Text('From: ${product.startDate.toString().split('T').first}'),
                  Text('To: ${product.endDate.toString().split('T').first}'),
                  // Text(product.shopName ?? " "),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(CartItemRepository());
    Get.put(ShopRepository());
    Get.put(ProductsViewModel());
  }
}
