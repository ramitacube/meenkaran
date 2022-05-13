class LocationData {
  int id;
  String name;
  String latitude;
  String longitude;
  String parentId;
  bool status;
  TalukId talukId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  LocationData(
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

  LocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    parentId = json['parent_id'];
    status = json['status'];
    talukId = json['taluk_id'] != null
        ? new TalukId.fromJson(json['taluk_id'])
        : null;
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
    if (this.talukId != null) {
      data['taluk_id'] = this.talukId.toJson();
    }
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