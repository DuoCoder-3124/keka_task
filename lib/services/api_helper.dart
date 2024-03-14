import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/modal/clockInOutModal.dart';
import 'package:keka_task/modal/register_modal.dart';
import 'package:keka_task/services/firebase_helper.dart';

class ApiService {
  static ApiService helper = ApiService._();

  ApiService._();

  final Dio _dio = Dio();

  /// post register data
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

  /// get register data
  // Future<List<ClockInOutModal>> getRegisterUser() async{
  //   try{
  //     Response response = await _dio.get(
  //       "http://192.168.1.121:3000/getEmployee",
  //     );
  //     if(response.statusCode == 200){
  //       List<ClockInOutModal> list = List<ClockInOutModal>.from(jsonDecode(response.data));
  //       return list;
  //     }else{
  //       throw Exception('Custome Exception');
  //     }
  //   }catch(e){
  //     throw Exception('Custome Exception =====> $e');
  //   }
  // }



  /// login
  Future<bool?> loginUser(
      {required String email, required String password}) async {
    var fcmToken = await FirebaseService().connectFirebase();

    try {
      var body = {
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      };

      var response = await _dio.post('http://192.168.1.121:3000/loginEmployee',
          data: body);

      final responseMessage = jsonDecode(response.data)['message'];

      if (response.statusCode == 200) {
        if (responseMessage == 'Success') {
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

  ///clock in & out
  Future<void> insertClockInData(
      {required ClockInOutModal clockInOutModal}) async {
    Response response = await _dio.post(
      "http://192.168.1.121:3000/clockAction",
      data: clockInOutModal.toJson(),
    );
    print('>>>>>>>>>> clock in response => ${response.data}');
    if (response.statusCode == 200) {
      print('>>>>>>>>>> success');
    } else {
      print('>>>>>>>>>> failed');//done  ha parameter me pass krna tha sirf
    }
  }

  /// read clock in and clock data
  Future<List<dynamic>> readClockInData({required String userId}) async {
    Response response = await _dio.get(
      "http://192.168.1.121:3000/getClockAction?userId=$userId",
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.data);
      var data = res['userData'];
      print('datas ====> $data');
      return data.map((e) => ClockInOutModal.fromJson(e)).toList();
    } else {
      throw Exception('>>>>>>>>>> failed');
    }
  }
}
