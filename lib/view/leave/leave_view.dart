import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text_field.dart';

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
            dateDifference: 0),
      ),
      child: const LeaveView(),
    );
  }

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply Leave')),
      body: BlocBuilder<LeaveCubit, LeaveState>(
        builder: (context, state) {
          var cubit = context.read<LeaveCubit>();
          return Center(
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
                      Column(
                        children: [
                          const Text('From'),
                          TextButton(
                            onPressed: () => cubit.selectFromDate(context),
                            child:
                                Text(state.selectFromDate.text, style: const TextStyle(color: CommonColor.blueColor)),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.symmetric(horizontal: Spacing.normal, vertical: Spacing.small),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Text('${state.dateDifference.toString()} days'),
                      ),
                      Column(
                        children: [
                          const Text('To'),
                          TextButton(
                            onPressed: () => cubit.selectToDate(context),
                            child: Text(state.selectToDate.text, style: const TextStyle(color: CommonColor.blueColor)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Gap(Spacing.normal),

                  const Text('Select type of leave you want to apply'),

                  const Gap(Spacing.normal),

                  DropdownButtonFormField(
                    hint: const Text('Select', style: TextStyle(fontWeight: TextWeight.regular)),
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    items: state.leaveType.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (value) => cubit.changeLeaveType(leaveTypeValue: value ?? ""),
                  ),

                  const Gap(Spacing.normal),

                  const Text('Note'),

                  const Gap(Spacing.normal),

                  CommonTextField(
                    hintText: 'Type here',
                  ),

                  const Gap(Spacing.normal),

                  const Text('Notify'),

                  const Gap(Spacing.normal),

                  CommonTextField(
                    hintText: 'Search Employee',
                  ),

                  const Gap(Spacing.normal),

                  CommonElevatedButton(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {},
                    child: Text(
                      'Request',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.normal)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
