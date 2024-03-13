import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:keka_task/modal/clockInOutModal.dart';

class ApiHelper {

  static ApiHelper instance = ApiHelper._();
  ApiHelper._();

  final Dio _dio = Dio();

  Future<void> insertClockInData({required ClockInOutModal clockInOutModal}) async{
    Response response = await _dio.post(
        'http://192.168.1.121:3000/clockAction',
        data: clockInOutModal.toJson()
    );
    if(response.statusCode == 200){
      debugPrint("data Inserted Successfully");
    }
    else{
      debugPrint("data Inserted Unsuccessfully");
    }
  }

}