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

  RxList<Product> products = <Product>[].obs; //menggunakan RxList untuk products yg tipenya model Product awalnya daatanya kosong

 
  void DownloadKataLog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("products").get(); //ambil semua document ygg ada di collection products

    //reset all data (modelsnya) agar tidak menjadi duplikat
    products([]);

    getData.docs.forEach((element) { //untuk mengambil data tiap document
      products.add(Product.fromJson(element.data())); //masukkan data ke models products yg diatas(kosong) 
    },);

    pdf.addPage(
      pw.MultiPage(
        //ganti ke pw.MultiPage karena pdfnya bisa lebih dari 1 halaman
        pageFormat: PdfPageFormat.a4,
        build: (context) => [ //multi page langsung return list

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
                products.length, //generate sebanyak jumlah products
                (index) => pw.TableRow(
                  
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(child: pw.Text('${index + 1}',),)
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(child: pw.Text('${products[index].code}',),) //sekarang ambil dari models products
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                       child: pw.Center(child: pw.Text('${products[index].name}',),)
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Center(child: pw.Text('${products[index].quantity}',),)
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.BarcodeWidget(
                        //widget untuk membuat qr code
                        data: '${products[index].code}', //buat barcode berdasarkan code
                        barcode: pw.Barcode.qrCode(), //tampilan barcode
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
