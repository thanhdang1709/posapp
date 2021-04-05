class StoreModel {
  int id;
  String storeId;
  int owner;
  String name;
  String address;
  String hotline;
  int provinceId;
  int districtId;
  int wardId;
  String lng;
  String lat;
  int categoryStoreId;
  int bannerId;
  int timeStart;
  int timeEnd;
  String bannerImage;
  int status;
  String createdAt;
  String updatedAt;

  StoreModel(
      {this.id,
      this.storeId,
      this.owner,
      this.name,
      this.address,
      this.hotline,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.lng,
      this.lat,
      this.categoryStoreId,
      this.bannerId,
      this.timeStart,
      this.timeEnd,
      this.bannerImage,
      this.status,
      this.createdAt,
      this.updatedAt});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    owner = json['owner'];
    name = json['name'];
    address = json['address'];
    hotline = json['hotline'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    lng = json['long'];
    lat = json['lat'];
    categoryStoreId = json['category_store_id'];
    bannerId = json['banner_id'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    bannerImage = json['banner_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['owner'] = this.owner;
    data['name'] = this.name;
    data['address'] = this.address;
    data['hotline'] = this.hotline;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['long'] = this.lng;
    data['lat'] = this.lat;
    data['category_store_id'] = this.categoryStoreId;
    data['banner_id'] = this.bannerId;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['banner_image'] = this.bannerImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
