import 'dart:convert';

import 'package:connectone_meenkaran/models/customerUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferenceHelper {
  FlutterSecureStorage _sharedPreference = FlutterSecureStorage();

  initSharedPreference() async {
    _sharedPreference = FlutterSecureStorage();
  }

  saveUser(String data) {
    _sharedPreference.write(key: "profile", value: data);
  }

  removeAll() async {
    await _sharedPreference.deleteAll();
  }

  Future<CustomerData> getUser() async {
    var data = await _sharedPreference.read(key: "profile");
    if (data != null) {
      return CustomerData.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }
}
