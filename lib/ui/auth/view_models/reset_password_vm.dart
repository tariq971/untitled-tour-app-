import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/data/AuthRepository.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/home/home.dart';

import '../forget_password.dart';

class ResetPasswordViewModel extends GetxController {
  AuthRepository authRepository = Get.find();
  var isLoading = false.obs;
  Future<void> reset(String email,) async {
    if (!email.contains("@")){
      Get.snackbar("Error", "Enter proper email");
      return;
    }
    try {
      await authRepository.resetPassword(email );
      Get.snackbar("Reset Password","A password reset email is sent to you at ${email} ");

      //   success
      Get.back();
    } on FirebaseAuthException catch (e) {
      //   error
      Get.snackbar("Error", e.message ?? "Failed to send reset password email");
    }

      isLoading.value = false;

  }

}
