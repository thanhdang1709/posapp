class Province {
  List<Data> data;

  Province({this.data});

  Province.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String province;
  String codeProvince;
  List<Districts> districts;

  Data({this.province, this.codeProvince, this.districts});

  Data.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    codeProvince = json['code_province'];
    if (json['districts'] != null) {
      districts = new List<Districts>();
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['code_province'] = this.codeProvince;
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  String district;
  String codeProvince;
  String codeDistrict;
  List<String> subDistricts;

  Districts({this.district, this.codeProvince, this.codeDistrict, this.subDistricts});

  Districts.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    codeProvince = json['code_province'];
    codeDistrict = json['code_district'];
    subDistricts = json['sub_districts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['code_province'] = this.codeProvince;
    data['code_district'] = this.codeDistrict;
    data['sub_districts'] = this.subDistricts;
    return data;
  }
}
