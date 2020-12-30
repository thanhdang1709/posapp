class TableModel {
  int id;
  String name;
  String description;

  TableModel({this.id, this.name, this.description});

  factory TableModel.fromJson(json) {
    return TableModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
