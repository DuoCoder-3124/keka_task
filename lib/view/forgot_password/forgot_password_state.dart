part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String? otp;
  GlobalKey<FormState> formKey;

  bool isVisible1;
  bool isVisible2;

  ForgotPasswordState({
    this.isVisible1=true,
    this.isVisible2=true,
    required this.passwordController,
    required this.confirmPasswordController,
    this.otp = '',
    required this.formKey,
    required this.otpController,
  });

  @override
  List<Object?> get props => [formKey, passwordController,confirmPasswordController,isVisible1,isVisible2, otpController, otp];

  ForgotPasswordState copyWith({
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? otpController,
    String? otp,
    GlobalKey<FormState>? formKey,
    bool? isVisible1,
    bool? isVisible2,
  }) {
    return ForgotPasswordState(
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
      otpController: otpController ?? this.otpController,
      otp: otp ?? this.otp,
      formKey: formKey ?? this.formKey,
      isVisible1: isVisible1 ?? this.isVisible1,
      isVisible2: isVisible2 ?? this.isVisible2,
    );
  }
}
