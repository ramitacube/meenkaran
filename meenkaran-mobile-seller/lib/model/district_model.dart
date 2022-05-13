class DistrictData {
  int id;
  String name;
  StateId stateId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  DistrictData(
      {this.id,
        this.name,
        this.stateId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    if (this.stateId != null) {
      data['state_id'] = this.stateId.toJson();
    }
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