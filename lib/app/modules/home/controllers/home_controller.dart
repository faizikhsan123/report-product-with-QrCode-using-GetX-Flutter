import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qrcode_getx/app/data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Product> products = <Product>[].obs;

  void DownloadKataLog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("products").get();

    products([]);

    getData.docs.forEach((element) {
      products.add(Product.fromJson(element.data()));
    });

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Center(
            child: pw.Text(
              "KataLog Products",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),

          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black, width: 2),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'No',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'Code',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'Name',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'Quantity',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(
                      'QrCode',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ],
              ),

              ...List.generate(
                products.length,
                (index) => pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(child: pw.Text('${index + 1}')),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(
                        child: pw.Text('${products[index].code}'),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(
                        child: pw.Text('${products[index].name}'),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(
                        child: pw.Text('${products[index].quantity}'),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.BarcodeWidget(
                        data: '${products[index].code}',
                        barcode: pw.Barcode.qrCode(),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/example.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }
}

Future<Product?> getProductByCode(String code) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final query = await firestore
        .collection("products")
        .where("code", isEqualTo: code)
        .get();

    if (query.docs.isEmpty) {
      Get.snackbar('Gagal', 'Produk tidak ditemukan');
      return null;
    }

    //karena kita makai where maka hasilnya berupa list jadi kita ambil data pertama

    var data = query.docs.first.data(); //ambil data pertama
    var product = Product.fromJson(data); //parsing data ke model

    Get.snackbar('Berhasil', 'Produk ditemukan: ${product.name}');
    return product;
  } catch (e) {
    print(e);
    Get.snackbar('Error', 'Terjadi kesalahan');
    return null;
  }
}
