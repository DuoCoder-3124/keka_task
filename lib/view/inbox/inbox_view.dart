import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_inbox_card.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/model/leave_model.dart';
import 'package:keka_task/services/api_helper.dart';

part 'inbox_cubit.dart';

part 'inbox_state.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  static const String routeName = '/inbox_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => InboxCubit(InboxState(leaveModelListValue: <LeaveModel>[]), context),
      child: const InboxView(),
    );
  }

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: CommonColor.white,
        title: CommonText(
          text: 'Inbox',
          color: CommonColor.white,
          fontWeight: FontWeight.bold,
          fontSize: TextSize.largeHHeading,
        ),
        backgroundColor: CommonColor.blueColor,
      ),
      body: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {

          var cubit=context.read<InboxCubit>();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(child: Image.asset(AppImages.inboxBackground,fit: BoxFit.fill)),
                Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(AppImages.inboxBackground), fit: BoxFit.fill)),
                    child: Center(
                      child: ListView.separated(
                        padding: PaddingValue.normal,
                        itemCount: state.leaveModelListValue.length,
                        itemBuilder: (context, index) {

                          if(state.leaveModelListValue.length==0){
                            return const Center(
                              child: Text(
                                'No Pending Requests',
                                style: TextStyle(color: Colors.grey, fontSize: TextSize.appBarTitle),
                              ),
                            );
                          }
                          else{
                          var selectedLeaveModel=state.leaveModelListValue[index];
                          return InboxCard(
                            leaveModel: selectedLeaveModel,
                          );}
                        },
                        separatorBuilder: (BuildContext context, int index) => const Gap(Spacing.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
// child: const Center(
// child: Text(
// 'No Pending Requests',
// style: TextStyle(color: Colors.grey, fontSize: TextSize.appBarTitle),
// ),
// ),
