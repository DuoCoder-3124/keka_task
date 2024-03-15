part of 'profile_view.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final BuildContext context;

  ProfileCubit(super.initialState, this.context) {
    getProfileData();
  }


  moveToUpdateScreen(){
    Navigator.pushNamed(context, RegisterView.routeName,arguments: UpdateArgumentPass(isNew: false,registerModel: state.registerModel));
  }

  Future<void> getProfileData() async {
    var userId = await ApiService.helper.getUserId() ?? '';

    await ApiService.helper.getUserDataById(userId).then((value) {
      emit(state.copyWith(registerModel: value));
    });
  }

  Future<void> logout() async {
    var userId = await ApiService.helper.getUserId() ?? '';
    await ApiService.helper.logoutUserById(userId).then((value) {
      if (value) {
        clearWhichUser();
        Navigator.pushNamedAndRemoveUntil(context, SplashScreen.routeName, (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'logout error');
      }
    });
  }


  Future<void> clearWhichUser() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('whichUser');
  }
}

