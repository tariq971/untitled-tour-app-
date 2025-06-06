import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/AuthRepository.dart';
import '../../../data/shop_repository.dart';
import '../../../model/Shop.dart';

class SignUpForShopViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  ShopRepository shopRepository= Get.find();
  
  var isLoading = false.obs;
  Future<void> signup(String email, String password ,String confirmPassword, String name,String type) async {
    if (!email.contains("@")){
      Get.snackbar("Error", "Enter proper email");
      return;
    }
    if (password.length<6){
      Get.snackbar("Error", "Password must be 6 character atleast");
      return;
    }
    if (password!=confirmPassword){
      Get.snackbar("Error", "password and confirm password do not match");
return;
    }
    try {
      await authRepository.signup(email, password);
      await shopRepository.addShop(Shop(authRepository.getLoggedInUser()!.uid, name, type));
      await authRepository.changeName(name);
      //   success
      Get.offAllNamed("/customer_home");
    } on FirebaseAuthException catch (e) {
      //   error
      Get.snackbar("Error", e.message ?? "Signup failed");
    }

    isLoading.value = false;

  }
  bool isUserLoggedIn(){
    return authRepository.getLoggedInUser()!= null;
  }
}
