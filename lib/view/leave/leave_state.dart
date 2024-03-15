part of 'leave_view.dart';

@immutable
class LeaveState extends Equatable {
  TextEditingController selectFromDate = TextEditingController();

  TextEditingController selectToDate = TextEditingController();

  TextEditingController leaveTypeController;

  TextEditingController noteController;

  TextEditingController notifyController;

  String? approverId;

  int? dateDifference;

  List<String> leaveType;

  String leaveTypeItem;

  GlobalKey<FormState> formKey;

  LeaveState({
    required this.selectFromDate,
    required this.selectToDate,
    required this.leaveTypeController,
    required this.noteController,
    required this.notifyController,
    required this.dateDifference,
    this.approverId = '',
    required this.formKey,
    this.leaveType = const [
      'Comp Offs',
      'Floater Leave',
      'Paid Leave',
      'Unpaid Leave',
    ],
    this.leaveTypeItem = 'Comp Offs',
  });

  @override
  List<Object?> get props => [
        selectFromDate,
        selectToDate,
        dateDifference,
        leaveType,
        leaveTypeItem,
        noteController,
        notifyController,
        leaveTypeController,
        formKey,
      ];

  LeaveState copyWith({
    TextEditingController? selectFromDate,
    TextEditingController? selectToDate,
    int? dateDifference,
    List<String>? leaveType,
    String? leaveTypeItem,
    TextEditingController? leaveTypeController,
    TextEditingController? noteController,
    TextEditingController? notifyController,
    GlobalKey<FormState>? formKey,
  }) {
    return LeaveState(
      selectFromDate: selectFromDate ?? this.selectFromDate,
      selectToDate: selectToDate ?? this.selectToDate,
      dateDifference: dateDifference ?? this.dateDifference,
      leaveType: leaveType ?? this.leaveType,
      leaveTypeItem: leaveTypeItem ?? this.leaveTypeItem,
      leaveTypeController: leaveTypeController ?? this.leaveTypeController,
      noteController: noteController ?? this.noteController,
      notifyController: notifyController ?? this.notifyController,
      formKey: formKey ?? this.formKey,
    );
  }
}
