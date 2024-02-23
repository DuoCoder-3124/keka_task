
part of 'login_cubit.dart';

class LoginState extends Equatable{

  TextEditingController emailController=TextEditingController();

  GlobalKey<FormState> formKey;

  LoginState({required this.emailController,required this.formKey});

  @override
  List<Object?> get props => [emailController,formKey];

  LoginState copyWith({
    TextEditingController? emailController,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      formKey: formKey ?? this.formKey,
    );
  }
}