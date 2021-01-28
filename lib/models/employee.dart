class EmployeeModel {
  int id;
  String name;
  String email;
  String phone;
  String address;
  int role;
  int status;
  String description;
  int totalOrder;
  EmployeeModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.description,
    this.role,
    this.status,
    this.totalOrder,
  });

  factory EmployeeModel.fromJson(json) {
    if (json == null) return null;
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      description: json['description'],
      totalOrder: (json['orders'] != null) ? json['orders'].length : 0,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  String get roleLabel {
    switch (role) {
      case 1:
        return 'Admin';
        break;
      case 2:
        return 'Thu ngân';
        break;
      case 3:
        return 'Bếp';
        break;
      case 4:
        return 'Menu';
        break;
      default:
        return null;
    }
  }
}
