//{id: 2, store_id: 24167a41-4136-4944-b378-ef216aa5bf1f, name: Ten leach hang, phone: 0339888746, address: dis chi ne, email: , avatar: null, deleted: 0, created_at: null, updated_at: null}

class CustomerModel {
  int id;
  String name;
  String phone;
  String address;
  String email;
  String avatar;
  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.avatar,
  });
  factory CustomerModel.fromJson(json) {
    if (json == null || json == 0) return null;
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
