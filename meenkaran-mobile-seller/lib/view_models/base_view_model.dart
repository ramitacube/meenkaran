import 'package:connectone_meenkaran_seller/network/api_client.dart';
import 'package:connectone_meenkaran_seller/network/network_exceptions.dart';
import 'package:connectone_meenkaran_seller/network/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  ApiClient apiClient;
  String useId;
  Response response = Response.Loading;
  BaseViewModel() {
    apiClient = ApiClient();
  }

  onException(NetworkException e) {
    print("${e.code}");
    setError();
  }

  setLoading() {
    response = Response.Loading;
    notifyListeners();
  }

  setSuccess() {
    response = Response.Success;
    notifyListeners();
  }

  setError() {
    response = Response.Success;
    notifyListeners();
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

enum Response { Loading, Error, Success }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
