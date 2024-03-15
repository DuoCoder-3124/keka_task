import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/modal/clockInOutModal.dart';
import 'package:keka_task/modal/leave_model.dart';
import 'package:keka_task/modal/register_modal.dart';
import 'package:keka_task/services/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static ApiService helper = ApiService._();

  ApiService._();

  final Dio _dio = Dio();

  /// post register data
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


  /// login


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

  ///clock in & out
  Future<void> insertClockInData(
      {required ClockInOutModal clockInOutModal}) async {
    Response response = await _dio.post(
      "http://192.168.1.121:3000/clockAction",
      data: clockInOutModal.toJson(),
    );
    if (response.statusCode == 200) {
      print('>>>>>>>>>> success');
    } else {
      print('>>>>>>>>>> failed');//done  ha parameter me pass krna tha sirf
    }
  }

  Future<List<dynamic>> readSingleClockData({required String userId,required String date}) async{
    Response response = await _dio.get(
      "http://192.168.1.121:3000/getClockAction?userId=$userId&date=$date"
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      var data = res['userData'];
      return data.map((e) => ClockInOutModal.fromJson(e)).toList();
    } else {
      throw Exception('>>>>>>>>>> failed');
    }
  }

  Future<List<dynamic>> readMultiClockData({required String userId}) async {
    Response response = await _dio.get(
        "http://192.168.1.121:3000/getClockAction?userId=$userId"
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      var data = res['userData'];
      return data.map((e) => ClockInOutModal.fromJson(e)).toList();
    } else {
      throw Exception('>>>>>>>>>> failed');
    }
  }

}




/*/// read clock in and clock data
  Future<List<dynamic>> readClockInData({required String userId,required String date,required bool isWholeDataRead}) async {
    Response response =
      isWholeDataRead
      ? await _dio.get(
        // true - multi
        "http://192.168.1.121:3000/getClockAction",
      )
      : await _dio.get(
        // false - single
          "http://192.168.1.121:3000/getClockAction?userId=$userId&date=$date",
      );


    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      var data = res['userData'];
      return data.map((e) => ClockInOutModal.fromJson(e)).toList();
    } else {
      throw Exception('>>>>>>>>>> failed');
    }
  }
*/
