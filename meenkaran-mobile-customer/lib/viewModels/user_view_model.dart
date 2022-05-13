import 'dart:convert';

import 'package:connectone_meenkaran/models/cusstomer_details_model.dart';
import 'package:connectone_meenkaran/models/customerModel.dart';
import 'package:connectone_meenkaran/models/customerUser.dart';
import 'package:connectone_meenkaran/models/daily_report_model.dart';
import 'package:connectone_meenkaran/models/member_mode.dart';
import 'package:connectone_meenkaran/models/reminderModel.dart';
import 'package:connectone_meenkaran/models/search_seller_model.dart';
import 'package:connectone_meenkaran/models/sellerModel.dart';
import 'package:connectone_meenkaran/models/seller_all_data.dart';
import 'package:connectone_meenkaran/models/userModel.dart';
import 'package:connectone_meenkaran/network/endpoints.dart';
import 'package:connectone_meenkaran/network/network_exceptions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

import 'base_view_model.dart';

class UserViewModel extends BaseViewModel {
  var hidePhone = false;
  CustomerData userModel;
  CustomerModel userId;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  bool hideStatus = false;
  var isLoggedIn = false;
  User user;
  List <AllData> allData = [];
  MemberData memberData = new MemberData();
  DailyReport dailyReportData = DailyReport();
  List<MemberData> memberList = [];
  List<SellersData> sellersList = [];
  List<SellersData> sellerDetails = [];
  List<SearchSellersData> searchList = [];
  List<ReminderData> remindersList = [];
  List<CustomerDetails> customerDetailsList = [];
  List<CustomerDetails> customerDetailsList1 = [];
  UserViewModel() {
    getUser();
  }

  getUser() async {
    setLoading();

    userModel = await sharedPreferenceHelper.getUser();
    if (userModel != null) {
      getSellers();
      var fcmToken = await FirebaseMessaging.instance.getToken();
      print("FCM:::::::" + fcmToken);
    } else {
      setError();
    }
  }

  getProfile() async {
    userModel = await sharedPreferenceHelper.getUser();
    if (user == null) {
      isLoggedIn = false;
      user = User();
    } else {
      isLoggedIn = true;
    }
    setSuccess();
    notifyListeners();
  }

  // Future<bool> register() async {
  //   setLoading();
  //   // await _getCurrentPosition();
  //   // user.hideStatus = hideStatus ? true : false;
  //   // user.publishedAt = DateTime.now().toIso8601String();
  //   try {
  //     var data =
  //         await apiClient.post("${EndPoints.register}", body: user.toJson());
  //     sharedPreferenceHelper.saveUser(jsonEncode(data));
  //     user = User.fromJson(data);
  //     isLoggedIn = true;
  //     // var isSave = await saveVisit();
  //     setSuccess();

  //     return true;
  //   } on NetworkException catch (e) {
  //     onException(e);
  //     return false;
  //   }
  // }

  Future<bool> login(String username, String password) async {
    setLoading();
    try {
      var data = await apiClient.post(EndPoints.login, body: {
        "identifier": '$username@customer.com',
        "password": password,
      });
      if (CustomerData.fromJson(data) != null) {
        setSuccess();
        //customerDetails(CustomerData.fromJson(data).user.id.toString());
        await sharedPreferenceHelper
            .saveUser(jsonEncode(CustomerData.fromJson(data)));
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
      return false;
    }
  }

  Future<bool> customerDetails(String id, String sellerId) async {
    var token = userModel.jwt;
    setLoading();
    try {
      apiClient
          .get("${EndPoints.customerDetails}user_id=$id")
          .then((value) async {
        customerDetailsList = (value as List)
            .map((data) => CustomerDetails.fromJson(data))
            .toList();
        if (customerDetailsList.isNotEmpty) {
          await apiClient.post("${EndPoints.addSeller}", headers: {
            "Content-Type": "application/json",
            'authorization': 'Bearer $token'
          }, body: {
            'user_id': sellerId,
            'customer_id': customerDetailsList[0].id,
          });
        } else {
          setError();
          return false;
        }
        getSellers();
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> addMember() async {
    setLoading();
    var userid = userModel.user.id;
    memberData.hideStatus = hideStatus ? true : false;
    memberData.custRefId = userModel.user.id.toString();
    // memberData.custLat = userLocation.custLat;
    // memberData.custLong = userLocation.custLong;
    memberData.publishedAt = DateTime.now().toIso8601String();
    try {
      await apiClient
          .get("${EndPoints.customerDetails}user_id=$userid")
          .then((value) async {
        customerDetailsList = (value as List)
            .map((data) => CustomerDetails.fromJson(data))
            .toList();
        memberData.custLong = customerDetailsList[0].custLong;
        memberData.custLat = customerDetailsList[0].custLong;
        if (customerDetailsList.isNotEmpty) {
          var data = await apiClient.post("${EndPoints.addMember}",
              //headers:{"Content-Type":"application/json","authorization": "Bearer $token"},
              body: memberData.toJson());

          // var isSave = await saveVisit();
          setSuccess();

          return true;
        }
      });
      return true;
    } on NetworkException catch (e) {
      onException(e);
      return false;
    }
  }

  getMembers() {
    setLoading();
    var id = userModel.user.id;
    try {
      apiClient.get("${EndPoints.getmembers}cust_ref_id=$id").then((value) {
        memberList =
            (value as List).map((data) => MemberData.fromJson(data)).toList();
        print('SellerList:$memberList');
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  searchSeller(phoneNo) async {
    setLoading();
    // var phoneNo = phoneNo;
    sellerDetails.clear();
    var sellerId;
    // var customerId = userModel.user.id;
    // var token = userModel.jwt;

    try {
      await apiClient
          .get("${EndPoints.searchSeller}phone_number=$phoneNo")
          .then((value) async {
        if (value != null || value != []) {
          searchList = (value as List)
              .map((data) => SearchSellersData.fromJson(data))
              .toList();
          sellerId = searchList[0].id;
          if (sellerId != null) {
            customerDetails(userModel.user.id.toString(), sellerId.toString());
          }
          setSuccess();
        }
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future<bool> isLogIn() async {
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

  logout() {
    user = null;
    sharedPreferenceHelper.removeAll();
  }

  getSellers() async {
    //var customerId=userModel.;
    var id = userModel.user.id;
    setLoading();
    try {
      apiClient
          .get("${EndPoints.customerDetails}user_id=$id")
          .then((value) async {
        customerDetailsList = (value as List)
            .map((data) => CustomerDetails.fromJson(data))
            .toList();
        if (customerDetailsList.isNotEmpty) {
          apiClient
              .get(
                  "${EndPoints.sellers}customer_id=${customerDetailsList[0].id}")
              .then((value) {
            sellersList = (value as List)
                .map((data) => SellersData.fromJson(data))
                .toList();
            setSuccess();
          });
        }
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future<bool> getDailyReport(String date, String sellerId) async {
    setLoading();
    try {
      await apiClient
          .get("${EndPoints.getDailyReport}$sellerId?date=$date")
          .then((value) async {
        dailyReportData = DailyReport.fromJson(value);
        await getSellersLocation(sellerId);
        setSuccess();
        return true;
      });
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  getSellersLocation(String sellerId) async {
    var id=userModel.user.id;
    setLoading();
    try {
      await apiClient
          .get("${EndPoints.getLocationData}user_id=$sellerId")
          .then((value) async {
        allData = (value as List).map((data) => AllData.fromJson(data)).toList();
        print(allData[0].userId.username);
        try {
          await apiClient
              .get("${EndPoints.customerDetails}user_id=$id")
              .then((value) async {
            customerDetailsList1 = (value as List)
                .map((data) => CustomerDetails.fromJson(data))
                .toList();

          });
          setSuccess();
        } on NetworkException catch (e) {
          onException(e);
          setError();
          return false;
        }

      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  Future<bool> getInitialReminders() async {
    await getUser();
    var useId = userModel.user.id;
    try {
      await apiClient
          .get("${EndPoints.customerDetails}user_id=$useId")
          .then((value) async {
        customerDetailsList = (value as List)
            .map((data) => CustomerDetails.fromJson(data))
            .toList();
        print(customerDetailsList[0].id);
        if (customerDetailsList.isNotEmpty) {
          await apiClient.post(
              '${EndPoints.getInitialReminders}?customer_id=${customerDetailsList[0].id}',
              body: {"customer_id": '${customerDetailsList[0].id}'});
          await getReminders();
          setSuccess();
        }
      });
      return true;
    } on NetworkException catch (e) {
      remindersList = [];
      onException(e);
      setSuccess();
      return true;
    }
  }

  getReminders() async {
    // var token = userModel.token;
    // remindersList.clear();
    // var userId = userModel.id;
    var id = userModel.user.id;

    setLoading();
    try {
      await apiClient
          .get("${EndPoints.customerDetails}user_id=$id")
          .then((value) async {
        customerDetailsList = (value as List)
            .map((data) => CustomerDetails.fromJson(data))
            .toList();
        print(customerDetailsList[0].id);
        if (customerDetailsList.isNotEmpty) {
          await apiClient
              .get(
                  "${EndPoints.getReminders}/?customer_id=${customerDetailsList[0].id}")
              .then((value) {
            remindersList = (value as List)
                .map((data) => ReminderData.fromJson(data))
                .toList();
          });
        }
      });
      setSuccess();
    } on NetworkException catch (e) {
      remindersList = [];
      onException(e);
      setSuccess();
    }
  }

  postReminders(double remKm) async {
    setLoading();
    var token = userModel.jwt;
    var id = userModel.user.id.toString();
    print(token);
    try {
      await apiClient.post(EndPoints.getReminders, headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $token"
      }, body: {
        "customer_id": '$id',
        "reminder_km": '${remKm.toString()}'
      });
      await getReminders();
      setSuccess();
    } on NetworkException catch (e) {
      onException(e);
      setError();
    }
  }

  deleteReminders(int id) async {
    var token = userModel.jwt;

    try {
      await apiClient.delete('${EndPoints.getReminders}/$id', headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $token"
      });
      await getReminders();
    } on NetworkException catch (e) {
      onException(e);
    }
  }
  // getUser() async {
  //   setLoading();

  //   user = await sharedPreferenceHelper.getUser();
  //   // if (user != null) {
  //   //   registerToken();
  //   // } else {
  //   //   setError();
  //   // }
  // }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    user.custLat = position.latitude.toString();
    user.custLong = position.longitude.toString();
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

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }

  changeHide(bool value) {
    hidePhone = value;
    print(hidePhone);
    notifyListeners();
  }
}
