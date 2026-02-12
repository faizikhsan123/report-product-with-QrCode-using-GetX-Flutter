import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController quantityC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void UpdateProduct(String name, int quantity, String id) async {
    CollectionReference products = firestore.collection("products");

    try {
      await products.doc(id).update({"name": name, "quantity": quantity});
      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Product Berhasil Diedti',
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );
    } catch (e) {
      print(e);
      Get.snackbar('gagal', 'Gagal Mengedit Product');
    }
  }

  void deleteProduct(String id) async {
    CollectionReference products = firestore.collection("products");

    try {
      await products.doc(id).delete();
      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Product Berhasil DIhapus',
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );
    } catch (e) {
      print(e);
      Get.snackbar('gagal', 'Gagal Mengedit Product');
    }
  }

  @override
  void onInit() {
    codeC = TextEditingController();
    nameC = TextEditingController();
    quantityC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    codeC.dispose();
    nameC.dispose();
    quantityC.dispose();
    super.dispose();
  }
}
