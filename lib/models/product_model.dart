class ProductModel {
  int id;
  String name;
  int price;
  int promoPrice;
  int catelogId;
  int stock;
  String imageUrl;
  String color;
  String note;
  String barCode;

  ProductModel({
    this.id,
    this.name,
    this.barCode,
    this.catelogId,
    this.imageUrl,
    this.color,
    this.stock,
    this.note,
    this.price,
    this.promoPrice,
  });
  factory ProductModel.fromJson(json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price']).toInt(),
      catelogId: (json['category_id']).toInt(),
      stock: (json['stock']).toInt(),
      promoPrice: json['promoPrice'] == null ? 0 : (json['promoPrice']).toInt(),
      imageUrl: json['default_image'],
      color: json['color'].toString(),
      barCode: json['barcode'].toString(),
      note: json['note'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
