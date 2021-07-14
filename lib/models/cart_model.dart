class CartModel {
  int productId;
  String storeId;
  int quantity;
  String productName;
  String productImage;
  int productPrice;
  String note;

  CartModel({this.productId, this.storeId, this.quantity, this.productName, this.productImage, this.productPrice, this.note});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    storeId = json['store_id'];
    quantity = json['quantity'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    note = json['note'];
  }

  Map toJson() => {
        'product_id': productId,
        'store_id': storeId,
        'quantity': quantity,
        'product_name': productName,
        'product_image': productImage,
        'product_price': productPrice,
        'note': note,
      };
}
