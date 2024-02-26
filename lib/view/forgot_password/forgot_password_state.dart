
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable{

  TextEditingController passwordController=TextEditingController();
  TextEditingController captchaController=TextEditingController();

  GlobalKey<FormState> formKey;

  ForgotPasswordState({ required this.passwordController,
    required this.formKey,
    required this.captchaController});

  @override
  List<Object?> get props => [formKey, passwordController,captchaController];

  ForgotPasswordState copyWith({
    TextEditingController? passwordController,
    TextEditingController? captchaController,
    GlobalKey<FormState>? formKey,
  }) {
    return ForgotPasswordState(
      passwordController: passwordController ?? this.passwordController,
      formKey: formKey ?? this.formKey,
      captchaController: captchaController ?? this.captchaController,
    );
  }

}