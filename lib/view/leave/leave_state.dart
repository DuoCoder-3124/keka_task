part of 'leave_view.dart';

@immutable
class LeaveState extends Equatable {
  TextEditingController selectFromDate = TextEditingController();

  TextEditingController selectToDate = TextEditingController();

  int? dateDifference;

  List<String> leaveType;

  String leaveTypeItem;

  LeaveState({
    required this.selectFromDate,
    required this.selectToDate,
    required this.dateDifference,
    this.leaveType = const [
      'Comp Offs',
      'Floater Leave',
      'Paid Leave',
      'Unpaid Leave',
    ],
    this.leaveTypeItem = 'Comp Offs',
  });

  @override
  List<Object?> get props => [selectFromDate, selectToDate, dateDifference, leaveType, leaveTypeItem];

  LeaveState copyWith({
    TextEditingController? selectFromDate,
    TextEditingController? selectToDate,
    int? dateDifference,
    List<String>? leaveType,
    String? leaveTypeItem,
  }) {
    return LeaveState(
      selectFromDate: selectFromDate ?? this.selectFromDate,
      selectToDate: selectToDate ?? this.selectToDate,
      dateDifference: dateDifference ?? this.dateDifference,
      leaveType: leaveType ?? this.leaveType,
      leaveTypeItem: leaveTypeItem ?? this.leaveTypeItem,
    );
  }
}
