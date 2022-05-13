class DailyReport {
  List<DailyRoute> dailyRoute;
  List<DailyItem> dailyItem;

  DailyReport({this.dailyRoute, this.dailyItem});

  DailyReport.fromJson(Map<String, dynamic> json) {
    if (json['daily_route'] != null) {
      dailyRoute = new List<DailyRoute>();
      json['daily_route'].forEach((v) {
        dailyRoute.add(new DailyRoute.fromJson(v));
      });
    }
    if (json['daily_item'] != null) {
      dailyItem = new List<DailyItem>();
      json['daily_item'].forEach((v) {
        dailyItem.add(new DailyItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dailyRoute != null) {
      data['daily_route'] = this.dailyRoute.map((v) => v.toJson()).toList();
    }
    if (this.dailyItem != null) {
      data['daily_item'] = this.dailyItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyRoute {
  String locationName;
  int locationId;
  String date;

  DailyRoute({this.locationName, this.locationId, this.date});

  DailyRoute.fromJson(Map<String, dynamic> json) {
    locationName = json['location_name'];
    locationId = json['location_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_name'] = this.locationName;
    data['location_id'] = this.locationId;
    data['date'] = this.date;
    return data;
  }
}

class DailyItem {
  String itemName;
  String itemDate;

  DailyItem({this.itemName, this.itemDate});

  DailyItem.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemDate = json['item_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_date'] = this.itemDate;
    return data;
  }
}