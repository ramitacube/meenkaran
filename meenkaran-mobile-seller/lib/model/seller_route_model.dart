class SellerRoutes {
  int id;
  UserId userId;
  LocationId locationId;
  String date;
  String publishedAt;
  String createdAt;
  String updatedAt;

  SellerRoutes(
      {this.id,
        this.userId,
        this.locationId,
        this.date,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  SellerRoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    locationId = json['location_id'] != null
        ? new LocationId.fromJson(json['location_id'])
        : null;
    date = json['date'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    if (this.locationId != null) {
      data['location_id'] = this.locationId.toJson();
    }
    data['date'] = this.date;
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
  var blocked;
  int role;
  String createdAt;
  String updatedAt;
  var phoneNumber;
  String address;

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