import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController quantityC;

  FirebaseFirestore firestore =
      FirebaseFirestore.instance; //inisialisasi firestore

  void addProduct(int code, String name, int quantity) async {
    CollectionReference products = firestore.collection("products");

    try {
      final dataproduct = await products.add({
        //untuk menambahkan data
        "code": code,
        "name": name,
        "quantity": quantity,
      });

      dataproduct.update({
        //product id didapat dari hasil tambah data (documnet) trs kita ambil idnya dankita update data awalnya
        "ProductId": dataproduct.id,
      });

      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Product Berhasil Ditambahkan',
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );
    } catch (e) {
      print(e);
      Get.snackbar('gagal', 'Gagal Menambahkan Product');
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
