import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String email;
  late String avatar;

  @override
  void initState() {
    super.initState();
    final userController = Get.find<UserController>();
    name = userController.name.value;
    email = userController.email.value;
    avatar = userController.avatarUrl.value;
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xff43cea2),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Avatar preview and editor
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.teal.shade200,
                      backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
                      child: avatar.isEmpty
                          ? Text(
                        userController.initials,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32),
                      )
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () async {
                        final urlController = TextEditingController(text: avatar);
                        await Get.defaultDialog(
                          title: "Edit Photo URL",
                          content: TextField(
                            controller: urlController,
                            decoration: const InputDecoration(
                              labelText: "Photo URL",
                            ),
                          ),
                          textConfirm: "Save",
                          textCancel: "Cancel",
                          onConfirm: () {
                            setState(() {
                              avatar = urlController.text;
                            });
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Name field
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Name can't be empty"
                    : null,
                onSaved: (value) => name = value!.trim(),
              ),
              const SizedBox(height: 18),
              // Email field
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@')
                    ? "Enter a valid email"
                    : null,
                onSaved: (value) => email = value!.trim(),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final userController = Get.find<UserController>();
                        userController.updateProfile(
                          newName: name,
                          newEmail: email,
                          newAvatar: avatar,
                        );
                        Get.back();
                        Get.snackbar("Profile Updated", "Your profile has been updated!",
                            backgroundColor: Colors.teal, colorText: Colors.white);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}