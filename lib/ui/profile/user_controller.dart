import 'package:get/get.dart';

class UserController extends GetxController {
  var name = "John Doe".obs;
  var email = "john.doe@example.com".obs;
  var avatarUrl = "".obs; // Default image URL or blank

  String get initials {
    if (name.value.trim().isEmpty) return "?";
    final parts = name.value.trim().split(" ");
    return parts.length == 1
        ? parts.first[0].toUpperCase()
        : (parts.first[0] + parts.last[0]).toUpperCase();
  }

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newAvatar,
  }) {
    name.value = newName;
    email.value = newEmail;
    avatarUrl.value = newAvatar;
  }
}