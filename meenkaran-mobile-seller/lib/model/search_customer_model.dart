class SearchCustomer {
  int id;
  String name;
  String phoneNo;
  String token;
  var hideStatus;
  String publishedAt;
  String createdAt;
  String updatedAt;
  String custLat;
  String custLong;

  SearchCustomer(
      {this.id,
        this.name,
        this.phoneNo,
        this.token,
        this.hideStatus,
        this.publishedAt,
        this.createdAt,
        this.updatedAt,
        this.custLat,
        this.custLong});

  SearchCustomer.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}