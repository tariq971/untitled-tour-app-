import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import '../../../data/AuthRepository.dart';
import '../../../data/media_repo.dart';
import '../../../data/fav_repository.dart';
import '../../../model/Fav.dart';

class AddProductViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ProductsRepository productsRepository = Get.find();
  MediaRepository mediaRepository = Get.find();
  var isSaving = false.obs;
  Rxn<XFile> image = Rxn<XFile>();

  Future<void> addProduct(String placeName, String rent,String days,String startDate,String endDate , Product? product) async {
    if (placeName.isEmpty) {
      Get.snackbar("Error", "Enter proper Name");
      return;
    }
    if (rent.isEmpty) {
      Get.snackbar("Error", "Enter proper Price");
      return;
    }if (days.isEmpty) {
      Get.snackbar("Error", "Enter proper days");
      return;
    }if (startDate.isEmpty) {
      Get.snackbar("Error", "Enter proper Start Date");
      return;
    }if (endDate.isEmpty) {
      Get.snackbar("Error", "Enter proper End Date");
      return;
    }
    isSaving.value = true;
    if (product == null) {
      Product product = Product(
        "",
        authRepository.getLoggedInUser()?.uid ?? "",
        placeName,
        int.parse(rent) as double,
        int.parse(days),
        DateTime.parse(startDate),
        DateTime.parse(endDate),

      );
     if(await uploadImage(product)==false) return;

      try {
        await productsRepository.addProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    } else {
      product.placeName = placeName;
      product.rent = double.parse(rent);
      product.days=int.parse(days);
      product.startDate= DateTime.parse(startDate);
      product.startDate=DateTime.parse(endDate);
      try {
        if (await uploadImage(product)==false)return;
        await productsRepository.updateProduct(product);
        Get.back(result: true);
      } catch (e) {
        Get.snackbar("Error", "An error occurred ${e.toString()}");
      }
    }
    isSaving.value = false;
  }
  Future<bool> uploadImage(Product product) async {
    if (image.value != null) {
      var imageResult = await mediaRepository.uploadImage(image.value!.path);
      if (imageResult.isSuccessful) {
        product.image = imageResult.url;
        return true;
      } else {
        Get.snackbar(
          "Error uploading image",
          imageResult.error ?? "Could not upload image due to error",
        );
        return false;
      }
    }
    return true;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    image.value = await picker.pickImage(source: ImageSource.gallery);
  }
}
