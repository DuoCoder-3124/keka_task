part of 'leave_view.dart';

class LeaveCubit extends Cubit<LeaveState> {
  LeaveCubit(super.initialState);

  void changeLeaveType({required String leaveTypeValue}){
    emit(state.copyWith(leaveTypeItem: leaveTypeValue));
  }

  DateTime? pickedFromDate=DateTime.now();
  DateTime? pickedToDate=DateTime.now();

  Future<void> selectFromDate(context) async {
  pickedFromDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );

    if (pickedFromDate != null) {
      String pickedFormattedFromDate = DateFormat('dd-MMM').format(pickedFromDate??DateTime.now());
      emit(state.copyWith(selectFromDate: TextEditingController(text: pickedFormattedFromDate)));
    }
    dateDifference();
  }

  Future<void> selectToDate(context) async {
    pickedToDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    if (pickedToDate != null) {
      String pickedFormattedToDate = DateFormat('dd-MMM').format(pickedToDate??DateTime.now());
      emit(state.copyWith(selectToDate: TextEditingController(text: pickedFormattedToDate)));
    }
    dateDifference();
  }

  void dateDifference(){
    var from=DateTime(pickedFromDate?.year??0,pickedFromDate?.month??0,pickedFromDate?.day??0);
    var to=DateTime(pickedToDate?.year??0,pickedToDate?.month??0,pickedToDate?.day??0);
    var difference=(to.difference(from).inHours/24).round()+1;
    emit(state.copyWith(dateDifference: (to.difference(from).inHours/24).round()+1));
    // return state.dateDifference??0;
  }
}
