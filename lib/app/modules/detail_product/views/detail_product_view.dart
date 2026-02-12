import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  final productmodel = Get.arguments; //tangkap data dari halaman sebelumnya (argument)

  @override
  Widget build(BuildContext context) {
    //isi data controller sebelumnya dengan data yg ada di model
    controller.codeC.text = productmodel.code.toString();
    controller.nameC.text = productmodel.name;
    controller.quantityC.text = productmodel.quantity.toString();

    return Scaffold(
      appBar: AppBar(title: const Text('DetailProductView'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: productmodel.code.toString(),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.codeC,
            autocorrect: false,
            readOnly: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Code Product',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama Product',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.quantityC,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Quantity Product',
            ),
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (controller.nameC.text.isNotEmpty &&
                  controller.quantityC.text.isNotEmpty) {
                controller.UpdateProduct(
                  controller.nameC.text,
                  int.parse(controller.quantityC.text),
                  productmodel .productId, //untuk mengambil id product dari argumen diatas (yg baru ditangkap)
                );
              }
              Get.snackbar('Gagal', 'Form harus diisi');
            },
            child: Text(
              "Update Product",
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
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Hapus Product',
                middleText: 'Apakah anda yakin ingin menghapus product ini?',
                actions: [ //untuk tombol
                  ElevatedButton(onPressed: () {
                    Get.back();
                  }, child: Text("Cancel ")),
                  ElevatedButton(onPressed: () {
                    controller.deleteProduct(productmodel.productId);
                    Get.back();
                  }, child: Text("Delete "))
                ],
              );
            },
            child: Text("Delete Product", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
