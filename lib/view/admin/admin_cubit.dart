part of 'admin_view.dart';

class AdminCubit extends Cubit<AdminState> {

  final BuildContext context;

  AdminCubit(super.initialState,this.context){
    getInboxData();
  }

  Future<void> changeApprovalStatus({required ApproveModel approveModel}) async {
    await ApiService.helper.updateLeaveStatus(approveModel,context).then((value) {
      getInboxData();
      Log.success("Updated");
      Navigator.pop(context);
    });
  }

  //adminId=""65f036ae1be13d738b000000""

  Future<void> getInboxData() async {
    var adminId = await ApiService.helper.getAdminId();
    return await ApiService.helper.getRequestLeaveByApproverId(adminId ?? "").then(
          (value) {
        emit(state.copyWith(leaveModelListValue: value));
      },
    );
  }
}
