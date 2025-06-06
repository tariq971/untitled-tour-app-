import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/order_repository.dart';
import 'package:untitled/data/shop_repository.dart';
import 'package:untitled/model/Order.dart';
import '../../data/AuthRepository.dart';
import '../../data/order_repository.dart';
import '../../data/fav_repository.dart';
import 'order_vm.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderViewModel orderViewModel;

  @override
  void initState() {
    super.initState();
    orderViewModel = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Page"),),

      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orderViewModel.orderItems.length,
                itemBuilder: (context, index) {
                  Order order =
                      orderViewModel.orderItems[index];
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),

                      child: ListTile(
                      // onLongPress: () {
                      //   Get.dialog(
                      //     AlertDialog(
                      //       content: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         // children: [
                      //           // TextButton(
                      //           //   child: const Text('Delete'),
                      //           //   onPressed: () {
                      //           //     Get.back();
                      //           //     orderViewModel.deleteOrderItem(
                      //           //       orderItemWithProduct.orderItem,
                      //           //     );
                      //           //   },
                      //           // ),
                      //         // ],
                      //       ),
                      //     ),
                      //   );
                      // },
                      title: Text(order.customerName),

                      trailing: Text(order.status??"pending"),


                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text( order.orderItems.fold("",(previousValue,element)=>previousValue+element.name+" , ",)),
                          Text("Total. ${order.getGrandTotal()}"),



                        ],
                      ),
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

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(OrderRepository());
    Get.put(ShopRepository());
    Get.put(OrderViewModel());
  }
}
