import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qrcode_getx/app/controllers/auth_controller.dart';
import 'package:qrcode_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>(); //import auth controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            late IconData icon; //untuk icon
            late String judul; //untuk judul
            late VoidCallback onTap; //ini untuk fungsinya

            switch (index) { //ini sesuai index jika index ... maka icon ... dan judul ... dan function akan menyesuaikan index 
              case 0:
              icon = Icons.post_add_rounded;
              judul = "Add product";
              onTap = () => Get.toNamed(Routes.ADD_PRODUCT);
                
                break;
              case 1:
              icon = Icons.list_alt_outlined;
              judul = "Products";
              onTap = () => Get.toNamed(Routes.ALL_PRODUCTS);
         
                break;
              case 2:
              icon = Icons.qr_code;
              judul = "Qr Code";
              onTap = (){
                print("Open camera");
              };
                
                break;
              case 3:
              icon = Icons.document_scanner_outlined;
              judul = "Katalog";
              onTap = (){
                print("Open Pdf");
              };
                
                break;
              default:
            }

            return Material(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  onTap(); //jalankan  ontap sesuai index
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50, color: Colors.white), //icon sesuai index
                    Text("${judul}"),
                  ],
                ),
              ),
            );
          },
        ),
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
