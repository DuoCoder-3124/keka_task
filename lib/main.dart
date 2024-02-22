import 'package:flutter/material.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:keka_task/view/main_view/main_view.dart';

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
      initialRoute: MainView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
    MainView.routeName:MainView.builder,
    LoginView.routeName:LoginView.builder,
  };
}
