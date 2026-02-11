import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:qrcode_getx/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance; //inisialisasi firebase auth

  void login(String email, String password) async {
    //function login
    try {

    await auth.signInWithEmailAndPassword(email: email, password: password);

      Get.offNamed(Routes.HOME);
    } catch (e) {
      print(e);
      Get.snackbar('Gagal', 'Gagal Login');
    }
  }

  void logout() async {
    //function logout
    try {
      auth.signOut();
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      print(e);
      Get.snackbar('Gagal', 'Gagal Logout');
    }
  }
}
