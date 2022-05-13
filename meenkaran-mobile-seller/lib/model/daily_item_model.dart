class DailyFish {
  int id;
  UserId userId;
  String idUser;
  String idItem;
  ItemId itemId;
  String date;
  String publishedAt;
  String createdAt;
  String updatedAt;

  DailyFish(
      {this.id,
        this.userId,
        this.idUser,
        this.idItem,
        this.itemId,
        this.date,
        this.publishedAt,
        this.createdAt,
        this.updatedAt});

  DailyFish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    itemId =
    json['item_id'] != null ? new ItemId.fromJson(json['item_id']) : null;
    date = json['date'];
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
    if (this.itemId != null) {
      data['item_id'] = this.itemId.toJson();
    }
    data['user_id'] = this.idUser;
    data['item_id'] = this.idItem;
    data['date'] = this.date;
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
  bool blocked;
  int role;
  String createdAt;
  String updatedAt;
  String phoneNumber;
  String address;

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
        this.address});

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
    return data;
  }
}

class ItemId {
  int id;
  String name;
  String publishedAt;
  String createdAt;
  String updatedAt;

  ItemId(
      {this.id, this.name, this.publishedAt, this.createdAt, this.updatedAt});

  ItemId.fromJson(Map<String, dynamic> json) {
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