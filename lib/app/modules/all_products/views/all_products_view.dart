import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_getx/app/data/models/product_model.dart';
import 'package:qrcode_getx/app/modules/LoadingView.dart';
import 'package:qrcode_getx/app/routes/app_pages.dart';

import '../controllers/all_products_controller.dart';

class AllProductsView extends GetView<AllProductsController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AllProductsView'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.allProducts(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.active) {
            var data = asyncSnapshot.data!.docs;

            if (data.isEmpty) {
              //jika snapshot tidak ada data
              return Center(child: Text("Data Kosong"));
            }
            return ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                //mengubah data firestore (Map) menjadi object Product (model)
              var product = Product.fromJson(data[index].data() as Map<String, dynamic>);
                

                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PRODUCT);
                    },
                    child: Container(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      height: 150,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.code.toString(), //mengambil data dari model
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(product.name ?? ""), //data dari model
                                Text(product.quantity.toString()),//data dari model 
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: QrImageView(
                                //widget qr
                                data: product.code.toString(), //datanya dari code product ini akan dijadikan qr
                                version: QrVersions.auto, //versi qr
                                size: 200.0, //ukuran qr
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return LoadingView();
        },
      ),
    );
  }
}
