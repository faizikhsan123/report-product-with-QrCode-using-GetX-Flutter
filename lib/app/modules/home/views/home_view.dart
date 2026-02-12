import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode_getx/app/controllers/auth_controller.dart';
import 'package:qrcode_getx/app/routes/app_pages.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
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
            late IconData icon;
            late String judul;
            late VoidCallback onTap;

            switch (index) {
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
                icon = Icons.qr_code; //qrcode
                judul = "Qr Code";
                onTap = () async {
                  String? res = await SimpleBarcodeScanner.scanBarcode( //res = hasil scan
                    context,
                    barcodeAppBar: const BarcodeAppBar( //tampilan appbar scan
                      appBarTitle: 'Test',
                      centerTitle: false,
                      enableBackButton: true,
                      backButtonIcon: Icon(Icons.arrow_back_ios),
                    ),
                    isShowFlashIcon: true, //flash
                    delayMillis: 2000,
                    cameraFace: CameraFace.front, //kamera belakang
                  );

                  //cek hasil scan
                  if (res != null && res != "-1") {
                    await getProductByCode(res); //jalanman getProductByCode 
                  } else {
                    Get.snackbar("Batal", "Scan dibatalkan");
                  }
                };
                break;
              case 3:
                icon = Icons.document_scanner_outlined;
                judul = "Katalog";
                onTap = () {
                  controller.DownloadKataLog();
                };

                break;
              default:
            }

            return Material(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  onTap();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50, color: Colors.white),
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
          authC.logout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
