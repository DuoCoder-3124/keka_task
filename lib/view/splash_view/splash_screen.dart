import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/services/firebase_helper.dart';
import 'package:keka_task/view/admin/admin_view.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash_screen';

  static Widget builder(BuildContext context) {
    return const SplashScreen();
  }

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(
      const Duration(seconds: 3),
      () async {

        Log.debug("isNewUser=====>${await isNewUser()}");
        Log.debug("isNewAdmin=====>${await isNewAdmin()}");

        if (await isNewUser() || await isNewAdmin()) {
          if (await whichUser() == 'user') {
            Navigator.pushReplacementNamed(context, BottomNavBarView.routeName);
          } else if (await whichUser() == 'admin') {
            Navigator.pushReplacementNamed(context, AdminView.routeName);
          }
          else{
            Fluttertoast.showToast(msg: 'Error while login the user and admin');
          }
        } else {
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Image.asset(AppImages.kekaName),
    );
  }

  Future<bool> isNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp = prefs.getBool('newUser');
    return temp ?? false;
  }

  Future<bool> isNewAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp = prefs.getBool('newApprover');
    return temp ?? false;
  }

  Future<String?> whichUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var whichUser = prefs.getString('whichUser');
    return whichUser;
  }
}
