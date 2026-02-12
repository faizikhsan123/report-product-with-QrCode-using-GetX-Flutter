import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart'; //import package pdf
import 'package:pdf/widgets.dart' as pw; //import widget pdf pw = pdf widget

class HomeController extends GetxController {
  void DownloadKataLog() async {
    final pdf = pw.Document(); //membuat objek dokumen PDF baru di Flutter.

    pdf.addPage(
      //menambahkan halaman ke dokumen
      pw.Page(
        pageFormat: PdfPageFormat.a4, //format halaman A4
        build: (context) => pw.Column(
          children: [
            pw.Center(
              child: pw.Text(
                "KataLog Products",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              //widget table
              border: pw.TableBorder.all(color: PdfColors.black, width: 2),
              children: [ //list utamanya
                pw.TableRow(
                  //untuk judul nya table
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

                //isi datanya pakai list generate
                ...List.generate( //arti ... adalah  Menyebarkan isi list ke dalam list lain (ini list anaknya dari list utama)
                  3, //item count
                  (index) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text('${index + 1}'),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text('12345678'),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text('Product'),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text('65'),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Text('qrcode'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    //simpan
    Uint8List bytes = await pdf.save();

    //mendapatkan direktori aplikasi
    final dir = await getApplicationDocumentsDirectory();

    //buat file kosong
    final file = File('${dir.path}/example.pdf');

    //masukkan data yg ada di bytes ke file kosong tadi
    await file.writeAsBytes(bytes);

    //open pdf
    await OpenFile.open(file.path);
  }
}
