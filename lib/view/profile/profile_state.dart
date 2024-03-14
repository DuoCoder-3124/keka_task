part of 'profile_view.dart';

class ProfileState extends Equatable {

  RegisterModel? registerModel;

  ProfileState({this.registerModel});

  @override
  List<Object?> get props => [registerModel];

  ProfileState copyWith({
    RegisterModel? registerModel,
  }) {
    return ProfileState(
      registerModel: registerModel ?? this.registerModel,
    );
  }
}
