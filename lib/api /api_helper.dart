import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keka_task/model/register_modal.dart';

class ApiService {
  static ApiService helper = ApiService._();

  ApiService._();

  final Dio _dio = Dio();

  Future<void> registerUser(RegisterModel registerModel) async {
    try {
      var body = {
        "firstName": 'jkashdjkash',
        "secondName": "fdsnjfbsdkj",
        "middleName": "Birendra Sisdkjfhisdjngh",
        "email": "ayfsdkjfjksn",
        "password": "1dhsbfcs6",
        "DOB": 54,
        "gender": "female",
        "department": "Flutter",
        "reportedBy": "Ajay Patel",
        "jobTitle": "trainee",
        "phoneNumber": "8866474780"
      };
      //
      // log('Enter');
      //
      // log("Body===>$body");

      var response = await Dio().post(
        "http://192.168.1.121:3000/registerEmployee",
        data: body,
      );
      //
      // log("Body2===>$body");
      //
      // log(response.toString());

      if (response.statusCode == 200) {
        print('Success');
      } else {
        log('Unsuccess');
      }
    } catch (error) {
      log('error====>$error');
    }
  }
}
// final response2 = await http.post(
//   Uri.parse("http://192.168.1.121:3000/registerEmployee"),
//   body: jsonEncode(body),
//   headers: {
//     'Content-Type': 'application/json',
//   },
// );
