class AllData {
  int id;
  UserId userId;
  String latitude;
  String longitude;
  String dateTime;
  String publishedAt;
  String createdAt;
  String updatedAt;

  AllData(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.dateTime,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  AllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    dateTime = json['date_time'];
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['date_time'] = this.dateTime;
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
  Null blocked;
  int role;
  String createdAt;
  String updatedAt;
  String phoneNumber;
  String address;
  var deviceToken;
  var custLat;
  var custLong;

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
        this.address,
        this.deviceToken,
        this.custLat,
        this.custLong});

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
    deviceToken = json['device_token'];
    custLat = json['cust_lat'];
    custLong = json['cust_long'];
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
    data['device_token'] = this.deviceToken;
    data['cust_lat'] = this.custLat;
    data['cust_long'] = this.custLong;
    return data;
  }
}
