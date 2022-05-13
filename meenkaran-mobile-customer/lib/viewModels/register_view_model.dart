import 'package:connectone_meenkaran/models/customerUser.dart';
import 'package:connectone_meenkaran/models/reminderModel.dart';
import 'package:connectone_meenkaran/models/userModel.dart';
import 'package:connectone_meenkaran/network/endpoints.dart';
import 'package:connectone_meenkaran/network/network_exceptions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  CustomerData userModel;
  // RegisterSellerData selectedData = new RegisterSellerData();
  User user = User();
  List<ReminderData> remindersList = [];
  // LocationData selectedLocation;
  var hidePhone = false;
  String userId;
  String userName;
  String userPhoneNum;
  String token;
  String lat;
  String long;
  Future<bool> register() async {
    // user.roles = "Seller";
    // selectedData.user = user;
    setLoading();
    try {
      var data = await apiClient.post(EndPoints.register, body: user.toJson());
      print(data);
      userId = RegisterUser.fromJson(data).user.id.toString();
      userName = RegisterUser.fromJson(data).user.username.toString();
      userPhoneNum = RegisterUser.fromJson(data).user.phoneNumber.toString();
      token = RegisterUser.fromJson(data).jwt.toString();
      // hidePhone = RegisterUser.fromJson(data).user.hideStatus;
      // print(useId);
      setSuccess();
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }

  Future<bool> registerUser() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    await _getCurrentPosition();
    try {
      var data = await apiClient.post(EndPoints.registerUser, body: {
        'name': '$userName',
        'phone_no': '$userPhoneNum',
        'user_id': '$userId',
        'cust_lat': '$lat',
        'cust_long': '$long',
        'token': '$token',
        'hide_status': '$hidePhone',
        'device_token': '$fcmToken'
      });
      // sharedPreferenceHelper.saveUser(jsonEncode(data));
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      showToast("User Already Exist...!");
      return false;
    } on Error {
      setError();
      showToast("User Already Exist...!");
      return false;
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    lat = position.latitude.toString();
    long = position.longitude.toString();
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
    notifyListeners();
  }
}
