part of 'inbox_view.dart';

class InboxCubit extends Cubit<InboxState> {
  final BuildContext context;

  InboxCubit(super.initialState, this.context) {
    getInboxData();
  }

  Future<void> getInboxData() async {
    var userId = await ApiService.helper.getUserId();
    return await ApiService.helper.getRequestLeaveById(userId ?? "").then(
      (value) {
        emit(state.copyWith(leaveModelListValue: value));
      },
    );
  }

  // Future<List<LeaveModel>> getInboxData() async {
  //   var userId = await ApiService.helper.getUserId();
  //   return await ApiService.helper.getRequestLeaveById(userId ?? "").then(
  //         (value) {
  //       emit(state.copyWith(leaveModelListValue: value));
  //       return value;
  //     },
  //   );
  // }
}
