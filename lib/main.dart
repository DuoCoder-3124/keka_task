import 'package:flutter/material.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:keka_task/view/forgot_password/forgot_password_view.dart';
import 'package:keka_task/view/home/home_view.dart';
import 'package:keka_task/view/inbox/inbox_view.dart';
import 'package:keka_task/view/leave/leave_view.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';
import 'package:keka_task/view/profile/profle_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: BottomNavBarView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
    BottomNavBarView.routeName:BottomNavBarView.builder,
    LoginView.routeName:LoginView.builder,
    LoginPasswordView.routeName:LoginPasswordView.builder,
    ForgotPasswordView.routeName:ForgotPasswordView.builder,
    HomeView.routeName:HomeView.builder,
    LeaveView.routeName:LeaveView.builder,
    InboxView.routeName:InboxView.builder,
    ProfileView.routeName:ProfileView.builder,
  };
}
