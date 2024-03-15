import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/modal/leave_model.dart';

class ApprovalCard extends StatelessWidget {
  final LeaveModel selectedLeaveModel;

  final int? approvalStatus;

  const ApprovalCard({super.key, required this.selectedLeaveModel, this.approvalStatus});

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.white, fontSize: TextSize.appBarTitle, fontWeight: TextWeight.semiBold),
              ),
              Text(
                // 'Leave status : ${getApprovalMessageById(leaveModel.isApproved??0)}',
                'Leave status : ${getApprovalMessageById(approvalStatus ?? 0)}',
                style: const TextStyle(color: Colors.white),
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

  String getApprovalMessageById(int id) {
    if (id == 0) {
      return "Approved";
    } else if (id == 1) {
      return "Rejected";
    } else {
      return "Pending";
    }
  }
}
