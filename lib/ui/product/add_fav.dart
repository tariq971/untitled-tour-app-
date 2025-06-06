import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/product/view_models/add_fav_vm.dart';
import '../../data/AuthRepository.dart';
import '../../data/media_repo.dart';
import '../../data/fav_repository.dart';
import '../../model/Fav.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProduct> {
  TextEditingController placeNameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  late AddProductViewModel addProductViewModel;

  Product? product;

  @override
  void initState() {
    super.initState();
    addProductViewModel = Get.find();
    product = Get.arguments;
    if (product != null) {
      placeNameController = TextEditingController(text: product?.placeName);
      rentController = TextEditingController(text: product?.rent.toString());
      daysController = TextEditingController(text: product?.days.toString());
      startDateController = TextEditingController(
        text: product?.startDate.toString(),
      );
      endDateController = TextEditingController(
        text: product?.endDate.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 25,
                children: [
                  Text(
                    "Add Product",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  Obx(
                    () =>
                        addProductViewModel.image.value == null
                            ? Icon(Icons.image, size: 80)
                            : Image.file(
                              File(addProductViewModel.image.value!.path),
                              width: 150,
                              height: 150,
                            ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addProductViewModel.pickImage();
                    },
                    child: Text("Pick image"),
                  ),
        
                  TextFormField(
                    controller: placeNameController,
                    decoration: InputDecoration(
                      labelText: "Place name",
                      hintText: " Enter Place name",
                      prefixIcon: Icon(Icons.abc),
                      prefixIconColor: Colors.green,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  TextFormField(
                    controller: rentController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Rent per Day ",
                      hintText: "Enter rent for tour per day",
                      prefixIcon: Icon(Icons.price_change),
                      prefixIconColor: Colors.green,
                      border: OutlineInputBorder(),
                    ),
                  ),TextFormField(
                    controller: daysController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Days for tour ",
                      hintText: "Enter days for tour",
                      prefixIcon: Icon(Icons.view_day),
                      prefixIconColor: Colors.green,
                      border: OutlineInputBorder(),
                    ),),
                      TextFormField(
                        controller: startDateController,
                        decoration: InputDecoration(labelText: "Start Date (YYYY-MM-DD)",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range),
                          prefixIconColor: Colors.green,),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Enter a date";
                          try {
                            final parts = value.split('-');
                            DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
                            return null;
                          } catch (e) {
                            return "Use YYYY-MM-DD format";
                          }
                        },
                      ),
                  // ),TextFormField(
                  //   controller: startDateController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     labelText: "Start Date ",
                  //     hintText: "Enter Start date",
                  //     prefixIcon: Icon(Icons.date_range),
                  //     prefixIconColor: Colors.green,
                  //     border: OutlineInputBorder(),
                  //   ),
                 //
                  TextFormField(
                    controller: endDateController,
                    decoration: InputDecoration(labelText: "End Date (YYYY-MM-DD)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range),
                      prefixIconColor: Colors.green,),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter a date";
                      try {
                        final parts = value.split('-');
                        DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
                        return null;
                      } catch (e) {
                        return "Use YYYY-MM-DD format";
                      }
                    },
                  ),
                  Obx(() {
                    return addProductViewModel.isSaving.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () {
                            addProductViewModel.addProduct(
                              placeNameController.text,
                              rentController.text,
                              daysController.text,
                              startDateController.text,
                              endDateController.text,
                              product,
                            );
                          },
                          child: Text("Saving"),
                        );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ProductsRepository());
    Get.put(MediaRepository());
    Get.put(AddProductViewModel());
  }
}
