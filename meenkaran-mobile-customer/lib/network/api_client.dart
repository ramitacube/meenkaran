import 'dart:collection';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'network_exceptions.dart';

class ApiClient {
  // SharedPreferenceHelper _sharedPreferenceHelper;
  static final ApiClient _singleton = ApiClient._internal();
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjMyMTI2Mjc5LCJleHAiOjE2MzQ3MTgyNzl9.j1qe4xRCyoDdUTM3p5HOosYfaU01L0AIWnmtG7saV6s";
  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    // _sharedPreferenceHelper = SharedPreferenceHelper();
  }

  //instantiate json decoder for json serialization

  final JsonDecoder _decoder = JsonDecoder();

//Get
  Future<dynamic> get(String url, {Map<String, String> header}) async {
    // var accessToken = await _sharedPreferenceHelper.authToken;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   throw NetworkException(
    //       message: "Network Not available, Please check connection", code: 999);
    // }
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print("URLLL==$url");
    return http
        .get(Uri.parse(url), headers: header)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print("RESPONSE==${response.body}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      }
      // else if (_decoder.convert(res)['error'] != null) {
      //   throw NetworkException(
      //       error: _decoder.convert(res)['error'],
      //       message: _decoder.convert(res)['errorMessage']);
      // }
      //  else if (_decoder.convert(res)['code'] != null &&
      //     _decoder.convert(res)['code'] != 0) {
      //   throw NetworkException(
      //       code: _decoder.convert(res)['code'],
      //       error: _decoder.convert(res)['message'],
      //       message: _decoder.convert(res)['message']);
      // }
      return _decoder.convert(res);
    });
  }

//Post
  Future<dynamic> post(String url,
      {Map<String, String> headers,
      Map<String, dynamic> body,
      encoding}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException(
          message: "Network Not available, Please check connection", code: 999);
    }
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
    }
    var bodyData = jsonEncode(body);
    print(jsonDecode(bodyData));
    print(url);

    return http
        .post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      } else if (_decoder.convert(res)['error'] != null) {
        throw NetworkException(
            error: _decoder.convert(res),
            message: _decoder.convert(res)['errorMessage']);
      } else if (_decoder.convert(res)['code'] != null &&
          _decoder.convert(res)['code'] != 0) {
        throw NetworkException(
            code: _decoder.convert(res)['code'],
            error: _decoder.convert(res),
            message: _decoder.convert(res)['message']);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException(
          message: "Network Not available, Please check connection", code: 999);
    }
    if (headers == null) {
      headers = HashMap<String, String>();
      headers['Content-Type'] = 'application/json';
    }

    return http
        .delete(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print("RESPONSE==${response.body}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw NetworkException(
            message: "Error fetching data from server", code: statusCode);
      }
      return _decoder.convert(res);
    });
  }
}
