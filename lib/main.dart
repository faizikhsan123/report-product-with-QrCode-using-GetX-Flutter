import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qrcode_getx/app/controllers/auth_controller.dart';
import 'package:qrcode_getx/app/modules/LoadingView.dart';
import 'package:qrcode_getx/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async { //async
  WidgetsFlutterBinding.ensureInitialized(); //tambahkan ini
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, //tambahkan ini
    ); //dan ini
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance; //ini untuk auth (streamnya)

  final authC = Get.put(AuthController(),permanent: true); //karena controller ini dipakai di seluruh aplikasi

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(), // stremnya dari yg diatas guna pengecekan auth ini bisa otomatis login juga jika dia sudah perna login
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) { //jika sedang loading
          return LoadingView();
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Qr Code",
          initialRoute:asyncSnapshot.hasData ? Routes.HOME : Routes.LOGIN, //jika punya data (sudah login) maka langsung ke home 
          getPages: AppPages.routes,
        );
      }
    );
  }
}