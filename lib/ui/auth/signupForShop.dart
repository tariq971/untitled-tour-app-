import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/auth/view_models/signupForShop_vm.dart';
import '../../data/AuthRepository.dart';
import '../../data/shop_repository.dart';

class SignUpForShopPage extends StatefulWidget {
  const SignUpForShopPage({super.key});

  @override
  State<SignUpForShopPage> createState() => _SignUpForShopPageState();
}

class _SignUpForShopPageState extends State<SignUpForShopPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SignUpForShopViewModel signUpForShopViewModel;
  String selectedType = "Beaches";
  // bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    signUpForShopViewModel = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (signUpForShopViewModel.isUserLoggedIn()) {
        Get.offAllNamed("/customer_home");
      }
    });
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  "SignUp For Shop to continue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: " Enter Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: " Enter shop Name",
                    labelText: " Shop Name",
                    prefixIcon: Icon(Icons.abc_outlined),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                  ),
                ),
                // SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "password",
                    hintText: "Enter password",
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: " Confirm password",
                    hintText: "Enter password again",
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.green,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                DropdownButton(
                  items: [
                    DropdownMenuItem(value: "Beaches",child: Text("Beaches"),),
                    DropdownMenuItem(value: "Mountains & Hiking Spots",child: Text("Mountains & Hiking Spots"),),
                    DropdownMenuItem(value: "National Parks & Wildlife Reserves",child: Text("National Parks & Wildlife Reserves"),),
                    DropdownMenuItem(value:"Waterfalls " ,child: Text("Waterfalls "),),
                    DropdownMenuItem(value: "Theme Parks",child: Text("Theme Parks"),),
                    DropdownMenuItem(value: "Modern Architectural Wonders",child: Text("Modern Architectural Wonders"),),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                  value: selectedType,
                ),
                Obx(() {
                  return signUpForShopViewModel.isLoading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          signUpForShopViewModel.signup(
                            emailController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                            nameController.text,
                            selectedType,
                          );
                          // if (_formKey.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     // SnackBar(
                          //     //   // content: Text('Password: ${passwordController.text}'),
                          //     // ),
                          //   );
                        },
                        child: Text("SignUpForShop"),

                        // child: Text("login"),
                      );
                }),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed("/login");
                  },
                  child: Text("Already have an account then! Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(ShopRepository());
    Get.put(SignUpForShopViewModel());
  }
}
