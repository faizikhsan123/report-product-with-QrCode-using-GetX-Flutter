import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qrcode_getx/app/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  
  final authC = Get.find<AuthController>(); //import auth controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: Center(
        child: Text('HomeView is working', style: TextStyle(fontSize: 20)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        authC.logout(); //untuk logout
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
