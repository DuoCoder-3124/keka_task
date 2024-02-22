import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_inbox_card.dart';

part 'inbox_cubit.dart';
part 'inbox_state.dart';

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
      body: Center(
        child: Padding(
          padding: PaddingValue.normal,
          child: Column(
             children: [
               InboxCard(),
               Gap(Spacing.normal),
               InboxCard(),
               Gap(Spacing.normal),
               InboxCard(),
               Gap(Spacing.normal),
               InboxCard(),
               Gap(Spacing.normal),
               InboxCard(),
               Gap(Spacing.normal),
             ],
          ),
        ),
      ),
    );
  }
}
