import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AddProductView'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.codeC,
            autocorrect: false,
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
            onPressed: () {},
            child: Text(
              "Add Product",
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
        ],
      ),
    );
  }
}
