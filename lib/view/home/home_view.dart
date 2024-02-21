import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/view/home/home_cubit.dart';
import 'package:keka_task/view/home/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeState()),
      child: const HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text('hi'),
      ),
    );
  }
}
