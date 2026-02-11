import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  late TextEditingController emailC;
  late TextEditingController passC;

  RxBool isHide = false.obs; //hide password

  @override
  void onInit() {
   
    ////untuk mengisi textfield saat pertama
    emailC = TextEditingController(text: "admin@gmail.com");
    passC = TextEditingController(text: "admin123");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }


}
