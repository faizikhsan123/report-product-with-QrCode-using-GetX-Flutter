import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  late TextEditingController emailC;
  late TextEditingController passC;

  RxBool isHide = false.obs; //hide password

  @override
  void onInit() {
    // TODO: implement onInit
    emailC = TextEditingController();
    passC = TextEditingController();
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
