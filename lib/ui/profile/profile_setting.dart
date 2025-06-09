import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'profile_icon.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profile & Settings"),
        backgroundColor: const Color(0xff43cea2),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Obx(() => ProfileIcon(
                    imageUrl: userController.avatarUrl.value,
                    initials: userController.initials,
                    radius: 48,
                    onTap: () {
                      // Optionally allow avatar preview/edit from here
                    },
                  )),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                    userController.name.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1),
                  )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    userController.email.value,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        letterSpacing: 0.5),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.teal),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.toNamed('/edit_profile');
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.teal),
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.snackbar("Coming Soon", "Password change coming soon!");
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.teal),
                    title: const Text("Language"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.snackbar("Coming Soon", "Language settings coming soon!");
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.teal),
                    title: const Text("Notifications"),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: Colors.teal),
                    title: const Text("About App"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Get.snackbar("About", "Tour App version 1.0.0\nBy Your Company");
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.redAccent)),
                    onTap: () {
                      Get.offAllNamed('/login');
                      Get.snackbar("Logged Out", "You have been logged out.");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "App version 1.0.0",
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
