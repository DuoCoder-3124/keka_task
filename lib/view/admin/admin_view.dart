import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/modal/approval_model.dart';
import 'package:keka_task/modal/leave_model.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/view/login/login_view.dart';

part 'admin_state.dart';

part 'admin_cubit.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  static String routeName = '/admin_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(const AdminState(leaveModelListValue: <LeaveModel>[]), context),
      child: const AdminView(),
    );
  }

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: CommonText(
          text: 'Admin',
          color: CommonColor.white,
          fontWeight: FontWeight.bold,
          fontSize: TextSize.largeHHeading,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await ApiService.helper.clearLoginUser();
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: CommonColor.blue,
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          var cubit = context.read<AdminCubit>();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ListView.separated(
                        padding: PaddingValue.normal,
                        itemCount: state.leaveModelListValue.length,
                        itemBuilder: (context, index) {
                          if (state.leaveModelListValue.length == 0) {
                            return const Center(
                              child: Text(
                                'No Pending Requests',
                                style: TextStyle(color: Colors.grey, fontSize: TextSize.appBarTitle),
                              ),
                            );
                          } else {
                            var selectedLeaveModel = state.leaveModelListValue[index];

                            ///CARD

                            return Container(
                              padding: PaddingValue.small,
                              decoration: const BoxDecoration(
                                color: CommonColor.blueColor,
                                borderRadius: BorderRadius.all(ShapeRadius.normal),
                              ),
                              // height: 100,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedLeaveModel.notify ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: TextSize.appBarTitle,
                                            fontWeight: TextWeight.semiBold),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Leave status : ',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          DropdownButton<String>(
                                            items: List.from(
                                              (state.approvalStatusValue).map<DropdownMenuItem<String>>(
                                                (String val) {
                                                  return DropdownMenuItem<String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                },
                                              ),
                                            ),
                                            dropdownColor: CommonColor.color2,
                                            borderRadius: BorderRadius.circular(0),
                                            isDense: true,
                                            alignment: Alignment.center,
                                            value: getApprovalMessageById(selectedLeaveModel.isApproved ?? 0),
                                            padding: const EdgeInsetsDirectional.all(5),
                                            style: TextStyle(color: CommonColor.white),
                                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                                            onChanged: (value) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('Do you want to $value the request'),
                                                    actions: [
                                                      CommonElevatedButton(
                                                        onPressed: () {
                                                          cubit.changeApprovalStatus(
                                                            approveModel: ApproveModel(
                                                              approverId: selectedLeaveModel.approverId,
                                                              isApproved: getApprovalIdByMessage(value ?? ""),
                                                              leaveId: selectedLeaveModel.leaveId,
                                                              reason: selectedLeaveModel.note,
                                                            ),
                                                          );
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
                                                        child: const Text('ok'),
                                                      ),
                                                      CommonElevatedButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal),
                                                        child: const Text('cancel'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              Log.debug('status ----> $value');
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Gap(Spacing.small),
                                  Text(
                                    'Your Leave Request for the dates ${selectedLeaveModel.from} - ${selectedLeaveModel.to} for ${selectedLeaveModel.note} was ${getApprovalMessageById(selectedLeaveModel.isApproved ?? 0)} by ${selectedLeaveModel.notify} as reason of ${selectedLeaveModel.note} ',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }
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

  String getApprovalMessageById(int id) {

    if (id == 0) {
      return "Approved";
    } else if (id == 1) {
      return "Rejected";
    } else {
      return "Pending";
    }
  }

  int getApprovalIdByMessage(String approvalMessage) {
    if (approvalMessage == "Approved") {
      return 0;
    } else if (approvalMessage == "Rejected") {
      return 1;
    } else {
      return 2;
    }
  }
}
