import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/auth/login.dart';
import 'package:untitled/ui/auth/signup.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/ui/auth/forget_password.dart';
import 'package:untitled/ui/auth/signupForShop.dart';
import 'package:untitled/ui/customer_home/customer_home.dart';
import 'package:untitled/ui/product/add_form.dart';
import 'package:untitled/ui/product/add_fav.dart';
import 'package:untitled/ui/product/form.dart';
import 'package:untitled/ui/product/fav.dart';
import 'package:untitled/ui/shop_home/shop_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: [
        GetPage(
          name: "/login",
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: "/signup",
          page: () => SignUpPage(),
          binding: SignUpBinding(),
        ),
        GetPage(name: "/signupForShop", page: ()=>SignUpForShopPage(),binding: SignUpForShopBinding()),

        GetPage(
          name: "/forget_password",
          page: () => ResetPasswordPage(),
          binding: ResetPasswordBinding(),
        ),
        GetPage(
          name: "/FormPage",
          page: () => FormPage(),
          binding: FormBinding(),
        ),
        GetPage(
          name: "/AddFormPage",
          page: () => AddFormPage(),
          binding: AddFormBinding(),
        ),

        // To go to the add form page
        GetPage(
          name: "/favourite",
          page: () => ProductPage(),
          binding: ProductsBinding(), // Add this binding
        ),
        GetPage(
          name: "/addFav",
          page: () => AddFormPage(),
          binding: AddFormBinding(), // Same binding for add page
        ),
        GetPage(name: "/customer_home", page:()=>CustomerHomePage(),binding: CustomerHomeBinding() ),
        GetPage(name: "/products", page: ()=>ProductPage(),binding: ProductsBinding()),
        GetPage(name: "/addProduct", page: ()=>AddProduct(), binding: AddProductBinding()),
        GetPage(name: "/shop_home", page:()=>ShopHomePage(),),
      ],

      initialRoute: "/login",
    );
  }
}
