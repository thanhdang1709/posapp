class UserModel {
  int id;
  String name;
  String email;
  String storeId;
  String storeName;
  String emailVerifiedAt;
  int status;
  int role;
  String phone;
  String address;
  String createdAt;
  String updatedAt;
  String logo;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.storeId,
    this.storeName,
    this.emailVerifiedAt,
    this.status,
    this.role,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.logo,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
