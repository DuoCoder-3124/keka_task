import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/model/leave_model.dart';
import 'package:keka_task/model/register_modal.dart';
import 'package:keka_task/services/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static ApiService helper = ApiService._();

  ApiService._();

  final Dio _dio = Dio();

  Future<RegisterModel?> getProfileDataById(String userId) async {
    try {
      var response = await _dio.get("http://192.168.1.121:3000/getEmployeeById?userId=$userId");

      var profileModel = RegisterModel.fromJson(jsonDecode(response.data)["userData"]);

      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }

      return profileModel;
    } catch (error) {
      log('error====>$error');
      return null;
    }
  }

  Future<void> registerUser(RegisterModel registerModel) async {
    try {
      var response = await _dio.post(
        "http://192.168.1.121:3000/registerEmployee",
        data: registerModel.toJson(),
      );

      Log.success("response===>${response.data}");

      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }
    } catch (error) {
      log('error====>$error');
    }
  }

  Future<void> updateUser({required RegisterModel registerModel}) async {
    try {
      var response = await _dio.put(
        "http://192.168.1.121:3000/updateEmployee",
        data: registerModel.toJson(),
      );

      Log.success("response===>${response.data}");

      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }
    } catch (error) {
      log('error====>$error');
    }
  }

  Future<bool?> loginUser({required String email, required String password}) async {
    var fcmToken = await FirebaseService.helper.connectFirebase();

    try {
      var body = {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      };

      var response = await _dio.post('http://192.168.1.121:3000/loginEmployee', data: body);

      Log.success('update response===>${response.data}');

      final responseMessage = jsonDecode(response.data)['message'];

      if (response.statusCode == 200) {
        if (responseMessage == 'Success') {
          storeUserId(jsonDecode(response.data)['userId']);
          setNewUser();
          Log.success('UserId===>${jsonDecode(response.data)['userId']}');
          Fluttertoast.showToast(msg: 'User login successfully');
          return true;
        } else if (responseMessage == 'Wrong Password') {
          Fluttertoast.showToast(msg: 'Wrong password entered');
          return false;
        } else {
          Fluttertoast.showToast(msg: 'Not found');
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: 'Fail to connect');
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: '$error');
      Log.error('error===>$error');
      return false;
    }
  }

  Future<bool> logoutUserById(String userId) async {
    try {
      var response = await _dio.get("http://192.168.1.121:3000/logoutEmployee?userId=$userId");

      final responseMessage = jsonDecode(response.data)['message'];

      if (response.statusCode == 200) {
        if (responseMessage == 'Success') {
          clearLoginUser();
          Fluttertoast.showToast(msg: 'User logout successfully');
          return true;
        } else {
          Fluttertoast.showToast(msg: 'Not found');
          return false;
        }
      } else {
        Fluttertoast.showToast(msg: 'Fail to connect');
        return false;
      }
    } catch (error) {
      Log.error('error===>$error');
      return false;
    }
  }

  Future<void> requestLeave(LeaveModel leaveModel) async {
    Log.debug("Modal map=====>${leaveModel.toMap()}");

    try {
      var response = await _dio.post(
        "http://192.168.1.121:3000/requestLeave",
        data: leaveModel.toMap(),
      );

      Log.success("response===>${response.data}");

      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }
    } catch (error) {
      log('error====>$error');
    }
  }

  Future<List<LeaveModel>> getRequestLeaveById(String userId) async {
    try {
      var response = await _dio.get("http://192.168.1.121:3000/getLeavesByEmployeeId?userId=$userId");

      List<dynamic> responseBody = jsonDecode(response.data)['leaveData'];

      var requestListValue = List<LeaveModel>.from(responseBody.map((e) => LeaveModel.fromMap(e)).toList());

      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }
      return requestListValue;
    } catch (error) {
      Log.error('error===>$error');
      return [];
    }
  }

  Future<void> verifyOtp({required String otp, required String token, required String password}) async {
    var response = await _dio.post(
      "http://192.168.1.121:3000/verifyToken?userEmail",
      data: {
        "otp": otp,
        "token":token,
        "password":password
      },
    );

    Log.success("response ====>${response.data}");

  }

  Future<({String otp, String token})> getTokenByEmail(String userEmail) async {
    var response = await _dio.post("http://192.168.1.121:3000/forgotPassword?userEmail", data: {"email": userEmail});

    Log.success("response otp====>${response.data}");
    String otp = jsonDecode(response.data)["otp"];
    String token = jsonDecode(response.data)["token"];
    return (token: token, otp: otp);
  }

  Future<void> storeUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
    Log.success('Shared prefs UserId===>${prefs.getString('userId')}');
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> setNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newUser', true);
  }

  Future<void> clearLoginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newUser', false);
  }
}
