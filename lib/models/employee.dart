class EmployeeModel {
  int id;
  String name;
  String email;
  String phone;
  String address;
  int role;
  int status;
  String description;
  EmployeeModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.description,
    this.role,
    this.status,
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
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
