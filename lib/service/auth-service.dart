import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'constants.dart';
import 'common.dart';

class LoginService {
  static final Client client = Client();
  // register user
  static Future<Map<String, dynamic>> signUp(body) async {
    final response = await client.post(Constants.baseURL + "users/register",
        body: json.encode(body), headers: {'Content-Type': 'application/json'});
    return json.decode(response.body);
  }

  // user login
  // static Future<Map<String, dynamic>> signIn(body) async {
  //   final response = await client.post(Constants.baseURL + "users/login",
  //       body: json.encode(body), headers: {'Content-Type': 'application/json'});
  //
  //   return json.decode(response.body);
  // }

  // verify email
  static Future<Map<String, dynamic>> verifyEmail(body) async {
    final response = await client.post(Constants.baseURL + "users/verify/email",
        body: json.encode(body), headers: {'Content-Type': 'application/json'});
    return json.decode(response.body);
  }

  // verify otp
  static Future<Map<String, dynamic>> verifyOtp(body, token) async {
    final response = await client.post(Constants.baseURL + "users/verify/OTP",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });
    return json.decode(response.body);
  }

  // reset password
  static Future<Map<String, dynamic>> resetPassword(body, token) async {
    final response = await client.post(
        Constants.baseURL + "users/reset-password",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> changePassword(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client.post(
        Constants.baseURL + "users/change-password",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });
    return json.decode(response.body);
  }

  // get user info
  static Future<Map<String, dynamic>> getUserInfo() async {
    String token;
    await Common.getToken().then((onValue) {
      token = onValue;
    });
    final response = await client.get(Constants.baseURL + "users/me", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    });
    Common.setUserInfo(json.decode(response.body));
    return json.decode(response.body);
  }

  // image upload
  static Future<Map<String, dynamic>> imageUpload(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client.post(
        Constants.baseURL + "utils/upload/profile/picture",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });
    return json.decode(response.body);
  }

  // image delete
  static Future<Map<String, dynamic>> imagedelete(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client
        .delete(Constants.baseURL + "utils/imgaeKit/delete/$key", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    });
    return json.decode(response.body);
  }

  // user data update
  static Future<Map<String, dynamic>> updateUserInfo(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client.patch(
        Constants.baseURL + "users/update/profile",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });
    return json.decode(response.body);
  }

  // set token

  // check token
  static Future<Map<String, dynamic>> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client.get(Constants.baseURL + "users/verify/token",
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getBanner() async {
    final response = await client.get(Constants.baseURL + "banner",
        headers: {'Content-Type': 'application/json'});
    Common.setBanner(json.decode(response.body));

    return json.decode(response.body);
  }

  // notification list

  static Future<Map<String, dynamic>> getOrderHistory(orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client
        .get(Constants.baseURL + "orders/info/$orderId", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> restoInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    final response = await client
        .get(Constants.baseURL + "users/admin/infomation", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    });
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> aboutUs() async {
    final response = await client
        .get(Constants.baseURL + "business/business/about/us", headers: {
      'Content-Type': 'application/json',
    });
    return json.decode(response.body);
  }
}
