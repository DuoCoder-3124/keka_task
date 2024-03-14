part of 'inbox_view.dart';

class InboxState extends Equatable {

  final List<LeaveModel> leaveModelListValue;

  const InboxState({required this.leaveModelListValue});

  @override
  List<Object?> get props => [leaveModelListValue];

  InboxState copyWith({
    List<LeaveModel>? leaveModelListValue,
  }) {
    return InboxState(
      leaveModelListValue: leaveModelListValue ?? this.leaveModelListValue,
    );
  }
}
