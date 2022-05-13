class NotificationModel {
  int id;
  CustomerId customerId;
  String date;
  ReminderId reminderId;
  String publishedAt;
  String createdAt;
  String updatedAt;

  NotificationModel(
      {this.id,
        this.customerId,
        this.date,
        this.reminderId,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    date = json['date'];
    reminderId = json['reminder_id'] != null
        ? new ReminderId.fromJson(json['reminder_id'])
        : null;
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId.toJson();
    }
    data['date'] = this.date;
    if (this.reminderId != null) {
      data['reminder_id'] = this.reminderId.toJson();
    }
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CustomerId {
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
  int userId;
  String deviceToken;

  CustomerId(
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

  CustomerId.fromJson(Map<String, dynamic> json) {
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
    userId = json['user_id'];
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
    data['user_id'] = this.userId;
    data['device_token'] = this.deviceToken;
    return data;
  }
}

class ReminderId {
  int id;
  int customerId;
  int reminderKm;
  String publishedAt;
  String createdAt;
  String updatedAt;

  ReminderId(
      {this.id,
        this.customerId,
        this.reminderKm,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  ReminderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    reminderKm = json['reminder_km'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['reminder_km'] = this.reminderKm;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
