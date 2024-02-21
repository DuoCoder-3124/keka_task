import 'package:flutter/material.dart';
import 'package:keka_task/view/home/home_view.dart';
import 'package:keka_task/view/login/login_view.dart';

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
      initialRoute: LoginView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
    HomeView.routeName:HomeView.builder,
    LoginView.routeName:LoginView.builder,
  };
}
