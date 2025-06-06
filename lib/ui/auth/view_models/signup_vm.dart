import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/data/AuthRepository.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/home/home.dart';

class SignUpViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  var isLoading = false.obs;
  Future<void> signup(String email, String password ,String confirmPassword,String name) async {
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
      await authRepository.changeName(name);
      //   success
      Get.offAllNamed("/customer_home");
    } on FirebaseAuthException catch (e) {
      //   error
      Get.snackbar("Error", e.message ?? "Login failed");
    }

    isLoading.value = false;

  }
  bool isUserLoggedIn(){
    return authRepository.getLoggedInUser()!= null;
  }
}
