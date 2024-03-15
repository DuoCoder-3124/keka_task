import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/modal/approval_model.dart';
import 'package:keka_task/modal/clockInOutModal.dart';
import 'package:keka_task/modal/leave_model.dart';
import 'package:keka_task/modal/register_modal.dart';
import 'package:keka_task/services/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static ApiService helper = ApiService._();

  ApiService._();

  final Dio _dio = Dio();


  Future<void> sendNotification({required String fcmToken, required String title, required String body}) async {
    try {
      var bodyData = {
        "fcmToken": fcmToken,
        "title": title,
        "body": body,
      };

      var response = await _dio.post("http://192.168.1.121:3000/sendNotification", data: bodyData);

      Log.debug("response notification=====>${response.data}");

      if (response.statusCode == 200) {
        Log.success("success");
      } else {
        Log.debug("Unsuccess");
      }
    } catch (error) {
      Log.error('error');
    }
  }

  ///**************************************************************************************


  Future<RegisterModel?> getUserDataById(String userId) async {
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
      if (response.statusCode == 200) {
        log('Success');
      } else {
        log('Unsuccessful');
      }
    } catch (error) {
      log('error====>$error');
    }
  }

  ///**************************************************************************************

  Future<String?> loginUser({required String email, required String password}) async {
    var fcmToken = await FirebaseService.helper.connectFirebase();

    try {
      var body = {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      };

      var response = await _dio.post('http://192.168.1.121:3000/loginEmployee', data: body);
      final responseMessage = jsonDecode(response.data)['message'];

      if (response.statusCode == 200) {
        if (responseMessage == 'Success' && (email != 'ayushmanhr@gmail.com' && password != "123456")) {
          storeUserId(jsonDecode(response.data)['userId']);
          setNewUser();
          Log.success('UserId===>${jsonDecode(response.data)['userId']}');
          Fluttertoast.showToast(msg: 'User login successfully');
          return 'user';
        }
        if (responseMessage == 'Success' && (email == 'ayushmanhr@gmail.com' && password == "123456")) {
          storeAprroverId(jsonDecode(response.data)['userId']);
          setNewApprover();
          Log.success('UserId===>${jsonDecode(response.data)['userId']}');
          Fluttertoast.showToast(msg: 'Admin login successfully');
          return 'admin';
        } else if (responseMessage == 'Wrong Password') {
          Fluttertoast.showToast(msg: 'Wrong password entered');
          return 'wrong password';
        } else {
          Fluttertoast.showToast(msg: 'Not found');
          return 'not found';
        }
      } else {
        Fluttertoast.showToast(msg: 'Fail to connect');
        return 'fail';
      }
    } catch (error) {
      Log.error('error===>$error');
      return 'error';
    }
  }

  Future<bool> logoutUserById(String userId) async {
    try {
      var response = await _dio.get("http://192.168.1.121:3000/logoutEmployee?userId=$userId");
      final responseMessage = jsonDecode(response.data)['message'];

      if (response.statusCode == 200) {
        if (responseMessage == 'Success') {
          clearLoginUser();
          clearLoginAprrover();
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

  ///**************************************************************************************

  Future<void> requestLeave(LeaveModel leaveModel) async {
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

  Future<void> updateLeaveStatus(ApproveModel approveModel) async {
    try {
      Log.debug("modal===>${approveModel.toMap()}");

      var response = await _dio.post("http://192.168.1.121:3000/approveLeave", data: approveModel.toMap());

      Log.success("update response ====>$response");

      if (response.statusCode == 200) {
        Log.success('Success');
      } else {
        Log.debug('Unsuccessful');
      }
    } catch (error) {
      Log.error('error===>$error');
    }
  }

  Future<List<LeaveModel>> getRequestLeaveByApproverId(String approverId) async {
    try {
      var response = await _dio.get("http://192.168.1.121:3000/getLeavesByNotifyId?approverId=$approverId");

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

  ///**************************************************************************************

  Future<void> verifyOtp({required String otp, required String token, required String password}) async {
    var response = await _dio.post(
      "http://192.168.1.121:3000/verifyToken?userEmail",
      data: {"otp": otp, "token": token, "password": password},
    );

    Log.success("response ====>${response.data}");
  }

  Future<Map<String,dynamic>> getTokenByEmail(String userEmail) async {
    var response = await _dio.post("http://192.168.1.121:3000/forgotPassword?userEmail", data: {"email": userEmail});

    Log.success("response otp====>${response.data}");
    String otp = jsonDecode(response.data)["otp"];
    String token = jsonDecode(response.data)["token"];
    return {"token": token, "otp": otp};
  }

  ///**************************************************************************************

  Future<void> storeUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
    Log.success('Shared prefs UserId===>${prefs.getString('userId')}');
  }

  Future<void> clearLoginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newUser', false);
  }

  Future<void> setNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newUser', true);
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  ///**************************************************************************************

  Future<void> storeAprroverId(String approverId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('approverId', approverId);
    Log.success('Shared prefs AprroverId===>${prefs.getString('approverId')}');
  }

  Future<void> clearLoginAprrover() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newApprover', false);
  }

  Future<void> setNewApprover() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('newApprover', true);
  }

  Future<String?> getAdminId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('approverId');
  }

  ///***************************************************************************************

  ///clock in & out
  Future<void> insertClockInData({required ClockInOutModal clockInOutModal}) async {
    Response response = await _dio.post(
      "http://192.168.1.121:3000/clockAction",
      data: clockInOutModal.toJson(),
    );
    if (response.statusCode == 200) {
      print('>>>>>>>>>> success');
    } else {
      print('>>>>>>>>>> failed'); //done  ha parameter me pass krna tha sirf
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
