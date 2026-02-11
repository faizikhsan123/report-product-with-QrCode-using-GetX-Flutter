import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qrcode_getx/app/controllers/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {

  final authC = Get.find<AuthController>(); //untuk memanggil authcontroller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            TextField(
              controller: controller.emailC,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),

            SizedBox(height: 20),

            Obx(
              () => TextField(
                textInputAction: TextInputAction.done,
                controller: controller.passC,
                obscureText: controller.isHide.value, //untuk password agar di hide
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHide.toggle(); //toggle untuk membalik niali ishide(bool)
                    },
                    icon: controller.isHide.value
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.emailC.text.isEmpty || controller.passC.text.isEmpty) {
                  Get.snackbar('Gagal', 'Email dan Password harus diisi');
                }
                else {
                  authC.login(controller.emailC.text, controller.passC.text);
                }
              },
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 11, horizontal: 1),
                backgroundColor: const Color.fromARGB(255, 66, 76, 84),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
