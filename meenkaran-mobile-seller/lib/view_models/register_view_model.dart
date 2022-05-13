import 'dart:convert';

import 'package:connectone_meenkaran_seller/model/district_model.dart';
import 'package:connectone_meenkaran_seller/model/location_model.dart';
import 'package:connectone_meenkaran_seller/model/seller_location_model.dart';
import 'package:connectone_meenkaran_seller/model/state_model.dart';
import 'package:connectone_meenkaran_seller/model/taluk_model.dart';
import 'package:connectone_meenkaran_seller/model/user_details_model.dart';
import 'package:connectone_meenkaran_seller/model/user_model.dart';
import 'package:connectone_meenkaran_seller/network/endpoints.dart';
import 'package:connectone_meenkaran_seller/network/network_exceptions.dart';
import 'package:connectone_meenkaran_seller/view_models/user_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'base_view_model.dart';
import 'package:http/http.dart' as http;

class RegisterViewModel extends BaseViewModel {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  List<DistrictData> districtList;
  List<StateData> stateList;
  RegisterSellerData selectedData = new RegisterSellerData();
  User user=User();
  SellerDetails selectedSellerData = SellerDetails();
  List<TalukData> talukList;
  List<LocationData> locationList;
  DistrictData selectedDistrict;
  StateData selectedState;
  TalukData selectedTalluk;
  LocationData selectedLocation;
  String UserId;
  SellerLocationData sellerLocationData= SellerLocationData();


  Future<bool> register() async {
    // if (selectedDistrict == null) {
    //   showToast("Please select district");
    //   return false;
    // } else if (selectedTalluk == null) {
    //   showToast("Please select taluk");
    //   return false;
    // } else if (selectedState == null) {
    //   showToast("Please Select State");
    //   return false;
    // }

    user.roles = "Seller";
    selectedData.user=user;
    setLoading();
    await _getCurrentPosition();
    try {
      var data = await apiClient.post(EndPoints.register, body: user.toJson()) ;
      if(data ==null){
        showToast("User Already Exist...!");
      }
      print(data);
      useId=RegisterSellerData.fromJson(data).user.id.toString();
      if(RegisterSellerData.fromJson(data).user !=null){
        return true;
      }else {
        setError();
        showToast("User Already Exist...!");
        return false;
      }

    } on NetworkException catch (e) {
      onException(e);
      setError();
      showToast("User Already Exist...!");
      return false;
    }on Error{
      setError();
      showToast("User Already Exist...!");
    }
  }

  Future<bool> registerSellerDetails() async {
    await _getCurrentPosition();
     selectedSellerData.idUser=useId;
     selectedSellerData.publishedAt=DateTime.now().toIso8601String();
    try {
      var data = await apiClient.post(EndPoints.registerSellerData, body: selectedSellerData.toJson()) ;
      return true;
    } on NetworkException catch (e) {
      onException(e);
      setError();
      return false;
    }
  }


  onChange(String type, value) {
    switch (type) {
      case "state":
        selectedState = value;
        selectedDistrict=null;
        selectedSellerData.idState = selectedState.id.toString();
        getDistricts(selectedState.id);
        break;
      case "district":
        selectedDistrict = value;
        selectedTalluk = null;
        selectedSellerData.idDistrict = selectedDistrict.id.toString();
        getTaluk(selectedDistrict.id);
        break;
      case "taluk":
        selectedTalluk = value;
        selectedLocation = null;
        selectedSellerData.idTaluk = selectedTalluk.id.toString();
        getLocation(selectedTalluk.id);
        break;
      case "location":
        selectedLocation= value;
        selectedSellerData.idLocation = selectedLocation.id.toString();
        selectedSellerData.shopLatitude = selectedLocation.latitude;
        selectedSellerData.shopLongitude = selectedLocation.longitude;

        break;
      case "phone":
        user.email = value;
        user.phoneNumber=value.split("@")[0];
        break;
      // case "email":
      //   user.email = value;
      //   break;
      case "address":
        user.address = value;

        break;
      case "sellername":
        user.username = value;
        break;
      case "password":
        user.password = value;
        break;
    }
    notifyListeners();
  }

  getState() async{
    setLoading();
    try {
      apiClient.get(EndPoints.getState).then((value) {
        stateList = (value as List).map((data) => StateData.fromJson(data)).toList();
        print(stateList[0].name);
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getDistricts(int stateId) async{
    setLoading();
    try {
      apiClient.get("${EndPoints.getDistricts}?state_id=$stateId").then((value) {
        districtList = (value as List).map((data) => DistrictData.fromJson(data)).toList();
        //DistrictData.fromJson(value) as List<DistrictData> ;
        if (districtList.isEmpty) {
          showToast("No District Found");
        }
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getTaluk(int distId) async{
    setLoading();
    try {
      apiClient.get("${EndPoints.getTaluk}?district_id=$distId").then((value) {
        talukList = (value as List).map((data) => TalukData.fromJson(data)).toList();
        if (talukList.isEmpty) {
          showToast("No Taluks Found");
        }
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
    }
  }

  getLocation(int talukId) async{
    setLoading();
    try {
      apiClient.get("${EndPoints.getlocation}?taluk_id=$talukId").then((value) {
        locationList = (value as List).map((data) => LocationData.fromJson(data)).toList();
        if (talukList.isEmpty) {
          showToast("No locations Found");
        }
        setSuccess();
      });
    } on NetworkException catch (e) {
      onException(e);
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
