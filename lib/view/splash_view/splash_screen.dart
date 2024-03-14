import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_images.dart';
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
        if (await isNewUser()) {
          Navigator.pushReplacementNamed(context, BottomNavBarView.routeName);
        }
        else{
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
      width:  MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Image.asset(AppImages.kekaName),
    );
  }

  Future<bool> isNewUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp = prefs.getBool('newUser');
    return temp ?? false;
  }
}
