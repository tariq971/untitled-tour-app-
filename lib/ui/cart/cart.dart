import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/fav_repository.dart';
import 'package:untitled/data/order_repository.dart';
import '../../data/AuthRepository.dart';
import '../../data/cart_repository.dart';
import '../../model/CartItemWithProduct.dart';
import 'cart_vm.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartViewModel cartViewModel;

  @override
  void initState() {
    super.initState();
    cartViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart Products",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.red),),),
      body: Obx(
        () {
          return Column(
            children: [
          Expanded(
            child: ListView.builder(
            itemCount: cartViewModel.cartItems.length,
              itemBuilder: (context, index) {
                CartItemWithProduct cartItemWithProduct = cartViewModel.cartItems[index];
                return ListTile(
                  onLongPress: () {
                    Get.dialog(AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                Get.back();
                                cartViewModel.deleteCartItem(cartItemWithProduct.cartItem);
                              },
                            )
                          ],)
                    ));
                  },
                  // title: Column(
                  //   children: [
                  //
                  //   ],
                  // ),
                  title: Text(cartItemWithProduct.product.placeName),
                  leading: cartItemWithProduct.product.image==null? Icon(Icons.image,size: 80,):Image.network(cartItemWithProduct.product.image!,height: 80,width: 80,),

                  trailing: Column(
                    children: [
                      Text("Rs. ${cartItemWithProduct.product.rent}"),
                      Text("Rs. ${cartItemWithProduct.getTotal()}")
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      IconButton(onPressed: () => cartViewModel.decrementQuantity(cartItemWithProduct.cartItem), icon: Icon(Icons.remove)),
                      Text(cartItemWithProduct.cartItem.quantity.toString()),
                      IconButton(onPressed: () => cartViewModel.incrementQuantity(cartItemWithProduct.cartItem), icon: Icon(Icons.add)),

                    ],
                  ),

                );
              },
            ),
          ),
              Row(
                children: [
                  Expanded(child: Text("Total: ${cartViewModel.getGrandTotal()}")),
                  // ElevatedButton(onPressed: (){
                  //
                  // }, child:Text("Checkout"))
                  Obx(()=>
                  cartViewModel.isLoading.value? CircularProgressIndicator():
                      ElevatedButton(onPressed: (){
                        cartViewModel.checkOut();
                      }, child: Text("CheckOut"))
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    // Get.put(FavRepository());
    Get.put(CartItemRepository());
    Get.put(OrderRepository());
    Get.put(CartViewModel());
  }
}
