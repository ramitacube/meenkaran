import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:connectone_meenkaran_seller/model/call_log_model.dart';
import 'package:connectone_meenkaran_seller/model/customer_model.dart';
import 'package:connectone_meenkaran_seller/model/daily_item_model.dart';
import 'package:connectone_meenkaran_seller/model/daily_report_model.dart';
import 'package:connectone_meenkaran_seller/model/daily_route_model.dart';
import 'package:connectone_meenkaran_seller/model/fish_model.dart';
import 'package:connectone_meenkaran_seller/model/location_model.dart';
import 'package:connectone_meenkaran_seller/model/notification_model.dart';
import 'package:connectone_meenkaran_seller/model/reminder_model.dart';
import 'package:connectone_meenkaran_seller/model/search_customer_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_Item_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_all_data.dart';
import 'package:connectone_meenkaran_seller/model/seller_location_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_route_model.dart';
import 'package:connectone_meenkaran_seller/model/user_details_model.dart';
import 'package:connectone_meenkaran_seller/model/user_model.dart';
import 'package:connectone_meenkaran_seller/network/endpoints.dart';
import 'package:connectone_meenkaran_seller/network/network_exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'base_view_model.dart';
import 'package:connectone_meenkaran_seller/view_models/register_view_model.dart';
import 'package:intl/intl.dart';
import 'dart:math' show cos, sqrt, asin;

class UserViewModel extends BaseViewModel {
  RegisterSellerData userModel;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  SellerDetails sellerData;
  DailyFish dailyFish = DailyFish();
  DailyRouteData dailyRoute = DailyRouteData();
  CallLogData callLogData = CallLogData();
  SearchCustomer searchCustomer = SearchCustomer();
  List<FishData> fishList = [];
  List<SellerItem> sellerItemList = [];
  List<SellerRoutes> sellerRoutesList = [];
  AllData allData;
  List<CustomerData> customerList = [];
  List<LocationData> locationList = [];
  List<SearchCustomer> searchCustomerList = [];
  List<CallLogData> callLogList = [];
  List<CallLogData> receivedCallList = [];
  List<ReminderModel> reminderList = [];
  List<NotificationModel> notificationList = [];
  DailyReport dailyReportData = DailyReport();
  SellerLocationData sellerLocationData = SellerLocationData();
  bool isStarted = false;
  Timer timer;

  String sellerLat;
  String sellerLong;

  UserViewModel() {
    getUser();
  }

  getUser() async {
    setLoading();
    userModel = await sharedPreferenceHelper.getUser();
    if (userModel != null) {
      getCustomer();
      getSellerItem();
    } else {
      setError();
    }
  }

  Future<bool> isLoggedIn() async {
    if (userModel == null) {
      userModel = await sharedPreferenceHelper.getUser();
      if (userModel != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  String get getStoreName => userModel.user.username;

  getTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM d');
    final String formatted = formatter.format(now);
    return formatted;
  }

  logout() {
    userModel = null;
    sharedPreferenceHelper.removeAll();
  }

  Future<bool> login(String username, String password) async {
    setLoading();
    try {
      var data = await apiClient.post(EndPoints.login, body: {
        "identifier": username + "@gmail.com",
        "password": password,
      });
      if (RegisterSellerData.fromJson(data).user != null) {
        setSuccess();
        sharedPreferenceHelper
            .saveUser(jsonEncode(RegisterSellerData.fromJson(data)));
        return true;
      } else {
        setError();
        showToast("Invalid Username or Password");
        return false;
      }
    } on NetworkException catch (e) {
      showToast("Invalid Username or Password");
      onException(e);
      setError();
      return false;
    } on Error {
      showToast("Invalid Username or Password");
    }
  }

  Future<bool> addDailyItems(int itemId) async {
    var token = userModel.jwt;
    print("token::" + token);
    dailyFish.idUser = userModel.user.id.toString();
    dailyFish.idItem = itemId.toString();
    dailyFish.date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    dailyFish.publishedAt = DateTime.now().toIso8601String();
    try {
      var data = await apiClient.post(EndPoints.addDailyFish,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: dailyFish.toJson());
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> addDailyRoute(int locationId) async {
    var token = userModel.jwt;
    print("token::" + token);
    dailyRoute.idUser = userModel.user.id.toString();
    dailyRoute.idLocation = locationId.toString();
    dailyRoute.date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    dailyRoute.publishedAt = DateTime.now().toIso8601String();
    try {
      var data = await apiClient.post(EndPoints.addDailyRoute,
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer $token"
          },
          body: dailyRoute.toJson());
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> createCall(int custId) async {
    var token = userModel.jwt;
    print("token::" + token);
    callLogData.idUser = userModel.user.id.toString();
    callLogData.idCustomer = custId.toString();
    callLogData.date = DateTime.now().toIso8601String();
    callLogData.publishedAt = DateTime.now()
        .toIso8601String(); //DateFormat("yyyy-MM-dd").format(DateTime.now());
    try {
      var data = await apiClient.post(EndPoints.createCall,
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer $token"
          },
          body: callLogData.toJson());
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  getAllData() async {
    setLoading();
    try {
      var token = userModel.jwt;
      var id = userModel.user.id;
      await apiClient.get("${EndPoints.getAllData}/$id").then((value) async {
        allData = AllData.fromJson(
            value); //(value as List).map((data) => AllData.fromJson(data)).toList();
        print(allData.userId.username);
        await getLocation(allData.talukId.id);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getLocation(int talukId) async {
    try {
      await apiClient
          .get("${EndPoints.getlocation}?taluk_id=$talukId")
          .then((value) async {
        locationList =
            (value as List).map((data) => LocationData.fromJson(data)).toList();
        await getSellerRoute();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getCallLog() async {
    setLoading();
    try {
      var token = userModel.jwt;
      var id = userModel.user.id;
      await apiClient
          .get("${EndPoints.getCallLog}user_id=$id")
          .then((value) async {
        callLogList = (value as List)
            .map((data) => CallLogData.fromJson(data))
            .toList()
            .reversed
            .toList();
        print(callLogData);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getCallLogReceived() async {
    setLoading();
    try {
      var token = userModel.jwt;
      var id = userModel.user.id;
      await apiClient
          .get("${EndPoints.getReceivedCall}user_id=$id")
          .then((value) async {
        receivedCallList = (value as List)
            .map((data) => CallLogData.fromJson(data))
            .toList()
            .reversed
            .toList();
        print(receivedCallList.length);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getFish() async {
    setLoading();
    try {
      await apiClient.get(EndPoints.getFish).then((value) {
        fishList =
            (value as List).map((data) => FishData.fromJson(data)).toList();
        getSellerItem();
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getSellerItem() async {
    var sellerId = userModel.user.id;
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    try {
      await apiClient
          .get("${EndPoints.getSellerItem}user_id=$sellerId&date=$date")
          .then((value) {
        sellerItemList =
            (value as List).map((data) => SellerItem.fromJson(data)).toList();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getSellerRoute() async {
    var sellerId = userModel.user.id;
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    try {
      await apiClient
          .get("${EndPoints.getSellerRoute}user_id=$sellerId&date=$date")
          .then((value) {
        sellerRoutesList =
            (value as List).map((data) => SellerRoutes.fromJson(data)).toList();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getCustomer() async {
    var sellerId = userModel.user.id;
    setLoading();
    try {
      apiClient.get("${EndPoints.getCustomer}user_id=$sellerId").then((value) {
        customerList = (value as List)
            .map((data) => CustomerData.fromJson(data))
            .toList()
            .reversed
            .toList();
        //print(customerList[0].customerId.name);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future<bool> addCustomer(var customerId) async {
    var token = userModel.jwt;
    print("token::" + token);
    var idUser = userModel.user.id.toString();
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    try {
      var data = await apiClient.post(EndPoints.addCustomer, headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $token"
      }, body: {
        "user_id": idUser,
        "customer_id": customerId,
        "published_at": date
      });
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> getSearchCustomer(String phone) async {
    try {
      await apiClient
          .get("${EndPoints.searchCustomer}phone_no=$phone")
          .then((value) {
        searchCustomerList = (value as List)
            .map((data) => SearchCustomer.fromJson(data))
            .toList();
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> getDailyReport(String date) async {
    var id = userModel.user.id;
    setLoading();
    try {
      await apiClient
          .get("${EndPoints.getDailyReport}$id?date=$date")
          .then((value) {
        dailyReportData = DailyReport.fromJson(value);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  sendNotification(String sLat1, String sLong1) async {
    var sellerId = userModel.user.id;
    var token = userModel.jwt;
    var date = DateFormat('yyy-MM-dd').format(DateTime.now());
    print(date);

    setLoading();
    try {
      apiClient
          .get("${EndPoints.getCustomer}user_id=$sellerId")
          .then((value) async {
        customerList = (value as List)
            .map((data) => CustomerData.fromJson(data))
            .toList()
            .reversed
            .toList();

        if (customerList.isNotEmpty) {
          for (int i = 0; i < customerList.length; i++) {
            var distance = await getKM(
                sLat1,
                sLong1,
                customerList[i].customerId.custLat,
                customerList[i].customerId.custLong);
            print(distance);


            await apiClient
                .get(
                    "${EndPoints.getReminder}customer_id=${customerList[i].customerId.id}&reminder_km=$distance")
                .then((value) async {
              reminderList = (value as List)
                  .map((data) => ReminderModel.fromJson(data))
                  .toList();
              if (reminderList.isNotEmpty) {
                await apiClient
                    .get(
                        "${EndPoints.getNotification}?reminder_id=${reminderList[0].id}&customer_id=${customerList[i].customerId.id}&date=$date")
                    .then((value) async {
                  notificationList = (value as List)
                      .map((data) => NotificationModel.fromJson(data))
                      .toList();
                  if (notificationList.isEmpty) {
                    try {
                      var data = await apiClient
                          .post(EndPoints.getNotification, headers: {
                        "Content-Type": "application/json",
                        "authorization": "Bearer $token"
                      }, body: {
                        "customer_id": customerList[i].customerId.id,
                        "date": date,
                        "reminder_id": reminderList[0].id,
                        "published_at": DateTime.now().toIso8601String()
                      });
                      await sendPush(customerList[i].customerId.deviceToken,
                          customerList[i].customerId.name);
                      return true;
                    } on NetworkException catch (e) {
                      onException(e);
                      setError();
                      return false;
                    }
                  }
                });
              }
            });

            // if(distance<=5){
            //   await sendPush(customerList[i].customerId.deviceToken,customerList[i].customerId.name);
            // }

          }
        }
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  sendPush(String deviceToken, String name) async {
    String firebaseKey =
        "key=AAAALIJkBNc:APA91bF3DPk_R_iMylkB0H4fJX8yZOxyxn_GYScFoPmh2Rx3ARMqR0uCMsz_u9uJoS-XITfGBW59wy0L8C2PopYNjRc06CrS-kmUuBLVNjJDVveDLdn57KpFNieOrKzGsaLYE9rpAZse";
    var sellerId = userModel.user.id;
    var nameSeller = userModel.user.username;
    print("*********Sending Notification**********");
    print("$name : $deviceToken");
    setLoading();
    try {
      var data =
          await apiClient.post("https://fcm.googleapis.com/fcm/send", headers: {
        "Content-Type": "application/json",
        "authorization": firebaseKey
      }, body: {
        "to": deviceToken,
        "notification": {
          "body" : "$nameSeller will reach at you shortly.",
          "OrganizationId":"2",
          "content_available" : true,
          "priority" : "high",
          "subtitle":"Elementary School",
          "title":"Hello $name",
          "sound": "cellphonenotif.mp3",
          "android_channel_id": "high_importance_channel"
        },
        "data": {
          "body" : "New Announcement assigned",
          "organization" :"Elementary school"
        }
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  int getKM(String lat1, String long1, String lat2, String long2) {
    var lt1 = double.parse(lat1);
    var lt2 = double.parse(lat2);
    var ln1 = double.parse(long1);
    var ln2 = double.parse(long2);

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lt2 - lt1) * p) / 2 +
        c(lt1 * p) * c(lt2 * p) * (1 - c((ln2 - ln1) * p)) / 2;
    var distance = 12742 * asin(sqrt(a));

    print("Distance::" + distance.toString());
    var id=int.parse(distance.toStringAsFixed(0));
    if(id<1){
      return 1;
    }else{
      return id;
    }
  }

  startTimer() {
    timer = Timer.periodic(Duration(minutes: 5), (timer) {
      updateLocation();
      isStarted = true;
    });
  }

  stopTimer() {
    timer.cancel();
    isStarted = true;
  }

  updateLocation() async {
    var token = userModel.jwt;
    await _getCurrentPosition();
    sellerLocationData.idUser = userModel.user.id.toString();
    sellerLocationData.dateTime = DateTime.now().toString();
    sellerLocationData.publishedAt = DateTime.now().toIso8601String();
    String lat = sellerLocationData.latitude;
    String long = sellerLocationData.longitude;
    try {
      var data = await apiClient.post(EndPoints.updateLocation,
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer $token"
          },
          body: sellerLocationData.toJson());

      sendNotification(lat, long);
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    sellerLocationData.latitude = position.latitude.toString();
    sellerLocationData.longitude = position.longitude.toString();

    sellerLat = position.latitude.toString();
    sellerLong = position.longitude.toString();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _updatePositionList(
        //   _PositionItemType.log,
        //   _kPermissionDeniedMessage,
        // );
        showToast("Please Enable Location Service");

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    return true;
  }
}
