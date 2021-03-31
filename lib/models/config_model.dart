class ConfigModel {
  String website;
  String email;
  String phone;
  String mobileVersion;
  String datetimeFormat;
  String descriptionNewVersion;
  String font;

  ConfigModel({
    this.website,
    this.email,
    this.phone,
    this.mobileVersion,
    this.datetimeFormat,
    this.descriptionNewVersion,
    this.font,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return ConfigModel(
        website: json['website'],
        email: json['email'],
        phone: json['phone'],
        mobileVersion: json['mobile_version'],
        datetimeFormat: json['datetime_format'] ?? 'dd/MM/yyyy',
        descriptionNewVersion: json['description_new_version'],
        font: json['font'] ?? 'roboto',
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website'] = this.website;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['mobile_version'] = this.mobileVersion;
    data['datetime_format'] = this.datetimeFormat;
    data['description_new_version'] = this.descriptionNewVersion;
    data['font'] = this.font;
    return data;
  }
}
