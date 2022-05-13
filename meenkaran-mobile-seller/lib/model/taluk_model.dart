class TalukData {
  int id;
  String name;
  DistrictId districtId;
  StateId stateId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  TalukData(
      {this.id,
        this.name,
        this.districtId,
        this.stateId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  TalukData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    districtId = json['district_id'] != null
        ? new DistrictId.fromJson(json['district_id'])
        : null;
    stateId = json['state_id'] != null
        ? new StateId.fromJson(json['state_id'])
        : null;
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.districtId != null) {
      data['district_id'] = this.districtId.toJson();
    }
    if (this.stateId != null) {
      data['state_id'] = this.stateId.toJson();
    }
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