class CatelogModel {
  int id;
  String name;
  CatelogModel({this.id, this.name});
  factory CatelogModel.fromJson(json) {
    return CatelogModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
