class CustomerDetails {
  int id;
  String name;
  String phoneNo;
  String token;
  bool hideStatus;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String custLat;
  String custLong;
  var custRefId;
  UserId userId;
  String deviceToken;

  CustomerDetails(
      {this.id,
        this.name,
        this.phoneNo,
        this.token,
        this.hideStatus,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.custLat,
        this.custLong,
        this.custRefId,
        this.userId,
        this.deviceToken});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNo = json['phone_no'];
    token = json['token'];
    hideStatus = json['hide_status'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    custLat = json['cust_lat'];
    custLong = json['cust_long'];
    custRefId = json['cust_ref_id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['token'] = this.token;
    data['hide_status'] = this.hideStatus;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cust_lat'] = this.custLat;
    data['cust_long'] = this.custLong;
    data['cust_ref_id'] = this.custRefId;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    data['device_token'] = this.deviceToken;
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