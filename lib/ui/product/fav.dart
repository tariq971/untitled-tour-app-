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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tour Places",),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Get.toNamed('/addProduct');
          if (result == true) {
            Get.snackbar("Product saved", "Product saved successfully");
          }
        },
        child: Icon(Icons.add),
      ),
      body: Obx(
            () {
          return ListView.builder(
            itemCount: productsViewModel.products.length,
            itemBuilder: (context, index) {
              Product product = productsViewModel.products[index];
              // print("Product: ${product.toMap()}");
              return ListTile(
                onLongPress: () {
                  Get.dialog(AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text('Edit'),
                            onPressed: () {
                              Get.back();
                              Get.toNamed('/addProduct',arguments: product);
                            },
                          ),
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              Get.back();
                              productsViewModel.deleteProduct(product);
                            },
                          )
                        ],)
                  ));
                },

                leading: product.image==null?Icon(Icons.image,size: 80,):Image.network(product.image!,height: 80,width: 80,),
                trailing: TextButton(onPressed: () {
                  productsViewModel.addToCart(product);
                }, child: Text("Add to cart")),

                title:
                // Text(product.placeName, style: TextStyle(fontWeight: FontWeight.bold)),
                // subtitle:   Text(product.rent.toString()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // my changes ok
                    Text(product.placeName, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(product.rent.toString()),
                    Text('Days: ${product.days}'),
                    Text('From: ${product.startDate.toString().split(' ').first}'),
                    Text('To: ${product.endDate.toString().split(' ').first}'),
                    Text(product.shopName??""),
                  ],
                ),
                // title: Text(product.placeName),
                // subtitle: Text(product.rent.toString()),
              );
            },
          );
        },
      ),
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
