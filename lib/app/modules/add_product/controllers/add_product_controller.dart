import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
 late TextEditingController codeC;
 late TextEditingController nameC;
 late TextEditingController quantityC;
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
