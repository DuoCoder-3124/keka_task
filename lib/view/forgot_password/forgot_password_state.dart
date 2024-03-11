
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable{

  TextEditingController passwordController=TextEditingController();
  TextEditingController captchaController=TextEditingController();
  String? captcha;
  GlobalKey<FormState> formKey;

  ForgotPasswordState({ required this.passwordController,
    this.captcha='',
    required this.formKey,
    required this.captchaController});

  @override
  List<Object?> get props => [formKey, passwordController,captchaController,captcha];

  ForgotPasswordState copyWith({
    TextEditingController? passwordController,
    TextEditingController? captchaController,
    GlobalKey<FormState>? formKey,
    String? captcha,
  }) {
    return ForgotPasswordState(
      passwordController: passwordController ?? this.passwordController,
      formKey: formKey ?? this.formKey,
      captchaController: captchaController ?? this.captchaController,
      captcha: captcha?? this.captcha,
    );
  }
}