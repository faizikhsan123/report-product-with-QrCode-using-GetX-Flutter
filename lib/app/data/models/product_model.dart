class Product {
  String? productId;
  int? code;
  String? name;
  int? quantity;

  Product({this.productId, this.code, this.name, this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    code = json['code'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ProductId'] = productId;
    data['code'] = code;
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}
