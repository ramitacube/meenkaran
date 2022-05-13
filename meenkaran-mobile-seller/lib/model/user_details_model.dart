class SellerDetails {
  int id;
  String sellerId;
  String categoryId;
  String shopLatitude;
  String shopLongitude;
  bool custHideStatus;
  String token;
  String idState;
  String idDistrict;
  String idTaluk;
  String idLocation;
  StateId stateId;
  DistrictId districtId;
  TalukId talukId;
  LocationId locationId;
  String publishedAt;
  String createdAt;
  String updatedAt;
  UserId userId;
  String idUser;

  SellerDetails(
      {this.id,
        this.sellerId,
        this.categoryId,
        this.shopLatitude,
        this.shopLongitude,
        this.custHideStatus,
        this.token,
        this.stateId,
        this.districtId,
        this.talukId,
        this.locationId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.userId,
      this.idUser});

  SellerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    categoryId = json['category_id'];
    shopLatitude = json['shop_latitude'];
    shopLongitude = json['shop_longitude'];
    custHideStatus = json['cust_hide_status'];
    token = json['token'];
    stateId = json['state_id'] != null
        ? new StateId.fromJson(json['state_id'])
        : null;
    districtId = json['district_id'] != null
        ? new DistrictId.fromJson(json['district_id'])
        : null;
    talukId = json['taluk_id'] != null
        ? new TalukId.fromJson(json['taluk_id'])
        : null;
    locationId = json['location_id'] != null
        ? new LocationId.fromJson(json['location_id'])
        : null;
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['category_id'] = this.categoryId;
    data['shop_latitude'] = this.shopLatitude;
    data['shop_longitude'] = this.shopLongitude;
    data['cust_hide_status'] = this.custHideStatus;
    data['state_id'] = this.idState;
    data['district_id'] = this.idDistrict;
    data['taluk_id'] = this.idTaluk;
    data['location_id'] = this.idLocation;
    data['token'] = this.token;
    data['user_id'] = this.idUser;
    if (this.stateId != null) {
      data['state_id'] = this.stateId.toJson();
    }
    if (this.districtId != null) {
      data['district_id'] = this.districtId.toJson();
    }
    if (this.talukId != null) {
      data['taluk_id'] = this.talukId.toJson();
    }
    if (this.locationId != null) {
      data['location_id'] = this.locationId.toJson();
    }
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    return data;
  }
}

class StateId {
  int id;
  String name;
  String publishedAt;
  String createdAt;
  String updatedAt;

  StateId(
      {this.id, this.name, this.publishedAt, this.createdAt, this.updatedAt});

  StateId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DistrictId {
  int id;
  String name;
  int stateId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  DistrictId(
      {this.id,
        this.name,
        this.stateId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  DistrictId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TalukId {
  int id;
  String name;
  int districtId;
  int stateId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  TalukId(
      {this.id,
        this.name,
        this.districtId,
        this.stateId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  TalukId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    districtId = json['district_id'];
    stateId = json['state_id'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district_id'] = this.districtId;
    data['state_id'] = this.stateId;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LocationId {
  int id;
  String name;
  String latitude;
  String longitude;
  String parentId;
  bool status;
  int talukId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  LocationId(
      {this.id,
        this.name,
        this.latitude,
        this.longitude,
        this.parentId,
        this.status,
        this.talukId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  LocationId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    parentId = json['parent_id'];
    status = json['status'];
    talukId = json['taluk_id'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['taluk_id'] = this.talukId;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserId {
  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  int role;
  String createdAt;
  String updatedAt;
  Null phoneNumber;
  Null address;

  UserId(
      {this.id,
        this.username,
        this.email,
        this.provider,
        this.confirmed,
        this.blocked,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.phoneNumber,
        this.address});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phoneNumber = json['phone_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}