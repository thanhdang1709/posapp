class AreaModel {
  int id;
  String storeId;
  String name;
  String description;
  int status;
  int deleted;
  int createdBy;
  String createdAt;
  int tableCount;

  AreaModel({
    this.id,
    this.storeId,
    this.name,
    this.description,
    this.status,
    this.deleted,
    this.createdBy,
    this.createdAt,
    this.tableCount,
  });

  AreaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    tableCount = json['tables_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}
