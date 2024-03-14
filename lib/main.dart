import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/temp.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:keka_task/view/forgot_password/forgot_password_view.dart';
import 'package:keka_task/view/home/home_view.dart';
import 'package:keka_task/view/inbox/inbox_view.dart';
import 'package:keka_task/view/leave/leave_view.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';
import 'package:keka_task/view/profile/profile_view.dart';
import 'package:keka_task/view/register/register_view.dart';
import 'package:keka_task/view/register/register_view.dart';
import 'package:keka_task/view/splash_view/splash_screen.dart';
import 'package:keka_task/view/splash_view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  // await setupFlutterNotifications();
  // }
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
        colorScheme: ColorScheme.fromSeed(seedColor: CommonColor.blueColor),
        useMaterial3: true,
      ),
      // initialRoute: BottomNavBarView.routeName,
      // initialRoute: isNewUser() ? LoginView.routeName : BottomNavBarView.routeName,
      // initialRoute: LoginView.routeName,
      initialRoute: SplashScreen.routeName,
      routes: route,
      // home: Temp(),
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
    SplashScreen.routeName:SplashScreen.builder,
    RegisterView.routeName:RegisterView.builder,
    LoginView.routeName:LoginView.builder,
    LoginPasswordView.routeName:LoginPasswordView.builder,
    ForgotPasswordView.routeName:ForgotPasswordView.builder,
    BottomNavBarView.routeName:BottomNavBarView.builder,
    HomeView.routeName:HomeView.builder,
    LeaveView.routeName:LeaveView.builder,
    InboxView.routeName:InboxView.builder,
    ProfileView.routeName:ProfileView.builder,
  };
}
