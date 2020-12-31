import 'package:pdf/widgets/icon.dart';

class StatusModel {
  int id;
  String title;
  IconData icon;
  bool isChecked;
  String createdAt;

  StatusModel({
    this.id,
    this.title,
    this.createdAt,
  });
  factory StatusModel.fromJson(json) {
    return new StatusModel(
        id: json['id'], title: json['title'], createdAt: json['created_at']);
  }
}
