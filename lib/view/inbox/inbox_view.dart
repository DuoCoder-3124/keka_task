import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  static const String routeName = '/inbox_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return InboxView();
  }

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('dfgvdcv'),
    );
  }
}
