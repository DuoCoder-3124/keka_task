import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/common_widget/common_text_field.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/modal/leave_model.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'leave_cubit.dart';

part 'leave_state.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  static const String routeName = '/leave_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveCubit(
        LeaveState(
          selectFromDate: TextEditingController(text: 'select date'),
          selectToDate: TextEditingController(text: 'select date'),
          dateDifference: 0,
          leaveTypeController: TextEditingController(),
          noteController: TextEditingController(),
          notifyController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
        ),
      ),
      child: const LeaveView(),
    );
  }

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {

  // GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: CommonColor.white,
        title: CommonText(
          text: 'Leave Request',
          color: CommonColor.white,
          fontWeight: FontWeight.bold,
          fontSize: TextSize.largeHHeading,
        ),
        backgroundColor: CommonColor.blueColor,
      ),
      body: BlocBuilder<LeaveCubit, LeaveState>(
        builder: (context, state) {
          var cubit = context.read<LeaveCubit>();
          return SingleChildScrollView(
            child: Form(
              key: state.formKey,
              child: Center(
                child: Padding(
                  padding: PaddingValue.normal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(Spacing.normal),

                      /// duration
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Text('From'),
                                TextButton(
                                  onPressed: () => cubit.selectFromDate(context),
                                  child:
                                      Text(state.selectFromDate.text, style: const TextStyle(color: CommonColor.blueColor)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: Spacing.normal, vertical: Spacing.small),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Text('${state.dateDifference.toString()} days'),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                const Text('To'),
                                TextButton(
                                  onPressed: () => cubit.selectToDate(context),
                                  child:
                                      Text(state.selectToDate.text, style: const TextStyle(color: CommonColor.blueColor)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Gap(Spacing.normal),

                      const Text('Select type of leave you want to apply'),

                      const Gap(Spacing.normal),

                      DropdownButtonFormField(
                        value: state.leaveTypeItem,
                        validator: (value)=>(value==null || value.isEmpty)?'Enter the leave type':null,
                        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        items: state.leaveType.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (value) => cubit.changeLeaveType(leaveTypeValue: value ?? ""),
                      ),

                      const Gap(Spacing.normal),

                      const Text('Note'),

                      const Gap(Spacing.normal),

                      CommonTextField(
                        controller: state.noteController,
                        validator: (value)=>value?.isEmpty??false?'field is required':null,
                        hintText: 'Type here',
                      ),

                      const Gap(Spacing.normal),

                      const Text('Notify'),

                      const Gap(Spacing.normal),

                      CommonTextField(
                        controller: state.notifyController,
                        validator: (value)=>value?.isEmpty??false?'field is required':null,
                        hintText: 'Search Employee',
                        suffixIcon: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(value: '65f036ae1be13d738b000000', child: Text('Suresh HR')),
                            ];
                          },
                          onSelected: (value) {
                            if (value == '65f036ae1be13d738b000000') {
                              state.notifyController.text='Suresh HR';
                              state.approverId=value;
                            }
                          },
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ),
                      ),

                      const Gap(Spacing.normal),

                      CommonElevatedButton(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        onPressed: () =>cubit.validateLeave(state.formKey,context),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.normal)),
                        child: const Text('Request', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
