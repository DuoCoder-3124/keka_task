part of 'admin_view.dart';

class AdminState extends Equatable {
  final List<LeaveModel> leaveModelListValue;

  final List<String> approvalStatusValue;

  const AdminState({
    required this.leaveModelListValue,
    this.approvalStatusValue = const ["Approved", "Rejected", "Pending"],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [leaveModelListValue];

  AdminState copyWith({
    List<LeaveModel>? leaveModelListValue,
  }) {
    return AdminState(
      leaveModelListValue: leaveModelListValue ?? this.leaveModelListValue,
    );
  }
}
