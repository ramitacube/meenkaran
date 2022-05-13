import 'call_log_model.dart';

class SellerLocationData {
  int id;
  String idUser;
  UserId userId;
  String latitude;
  String longitude;
  String dateTime;
  String publishedAt;
  String createdAt;
  String updatedAt;

  SellerLocationData({this.id, this.idUser, this.latitude, this.longitude, this.dateTime, this.publishedAt, this.createdAt, this.updatedAt});

  SellerLocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['user_id'];
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
    data['user_id'] = this.idUser;
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
