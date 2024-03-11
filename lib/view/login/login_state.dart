
part of 'login_view.dart';

class RegisterState extends Equatable{

  TextEditingController emailController=TextEditingController();
  GlobalKey<FormState> formKey;

  RegisterState({required this.emailController,required this.formKey});

  @override
  List<Object?> get props => [emailController,formKey];

  RegisterState copyWith({
    TextEditingController? emailController,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterState(
      emailController: emailController ?? this.emailController,
      formKey: formKey ?? this.formKey,
    );
  }
}