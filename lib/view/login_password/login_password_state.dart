
part of 'login_password_cubit.dart';

class LoginPasswordState extends Equatable{

  final bool isVisible;

  const LoginPasswordState({this.isVisible=false});

  @override
  List<Object?> get props => [isVisible];

  LoginPasswordState copyWith({bool? isVisible}){
    return LoginPasswordState(isVisible: isVisible ?? this.isVisible);
  }

}