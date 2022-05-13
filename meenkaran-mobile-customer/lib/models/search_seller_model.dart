class SearchSellersData {
  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  var blocked;
  Role role;
  String createdAt;
  String updatedAt;
  String phoneNumber;
  String address;
  var deviceToken;
  String custLat;
  String custLong;

  SearchSellersData(
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

  SearchSellersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
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
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
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

class Role {
  int id;
  String name;
  String description;
  String type;

  Role({this.id, this.name, this.description, this.type});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}