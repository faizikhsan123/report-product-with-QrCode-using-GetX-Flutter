import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> allProducts() { //stream dari firebase
    CollectionReference products = firestore.collection("products");
    return products.snapshots();
  }
}
