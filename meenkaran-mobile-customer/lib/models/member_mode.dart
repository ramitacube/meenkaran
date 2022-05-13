class MemberData {
  int id;
  String name;
  String phoneNo;
  String token;
  var hideStatus;
  String publishedAt;
  String createdAt;
  String updatedAt;
  var custLat;
  var custLong;
  String custRefId;

  MemberData(
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
        this.custRefId});

  MemberData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}