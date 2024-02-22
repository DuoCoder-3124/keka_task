import 'package:flutter/material.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  static const String routeName = '/leave_view';

  static Widget builder(BuildContext context) {
   // final args = ModalRoute.of(context)?.settings.arguments;
    return LeaveView();
  }

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
