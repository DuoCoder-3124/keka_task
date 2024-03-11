part of 'login_password_cubit.dart';

class LoginPasswordState extends Equatable {
  bool isVisible;

  TextEditingController passwordController=TextEditingController();
  TextEditingController captchaController=TextEditingController();
  String? captcha;
  GlobalKey<FormState> formKey;

  LoginPasswordState(
      {this.isVisible = true,
      required this.passwordController,
      required this.formKey,
      required this.captchaController,
      this.captcha=''});

  @override
  List<Object?> get props => [isVisible, formKey, passwordController,captchaController,captcha];

  LoginPasswordState copyWith({
    bool? isVisible,
    TextEditingController? passwordController,
    TextEditingController? captchaController,
    GlobalKey<FormState>? formKey,
    String? captcha,
  }) {
    return LoginPasswordState(
      isVisible: isVisible ?? this.isVisible,
      passwordController: passwordController ?? this.passwordController,
      formKey: formKey ?? this.formKey,
      captchaController: captchaController ?? this.captchaController,
      captcha: captcha ?? this.captcha,
    );
  }
}
