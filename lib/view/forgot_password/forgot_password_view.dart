import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_rich_text.dart';
import 'package:keka_task/common_widget/common_text_field.dart';
import 'package:keka_task/view/forgot_password/forgot_password_cubit.dart';

class TokenArgumentPass {
  String? email;
  String? token;
  String? otp;

  TokenArgumentPass({
    this.email = '',
    this.token = '',
    this.otp = '',
  });
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  static String routeName = '/forgot_password_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as TokenArgumentPass;
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        ForgotPasswordState(
            confirmPasswordController: TextEditingController(),
            passwordController: TextEditingController(),
            formKey: GlobalKey<FormState>(),
            otpController: TextEditingController()),
        context: context,
        tokenArgumentPass: args,
      ),
      child: const ForgotPasswordView(),
    );
  }

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          var cubit = context.read<ForgotPasswordCubit>();
          return Form(
            key: state.formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: PaddingValue.normal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(Spacing.xxxLarge),
                    const Text(
                      'Forgot your password?',
                      style: TextStyle(fontSize: TextSize.appBarTitle),
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.passwordController,
                      hintText: 'Enter password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      isVisiblePassword: state.isVisible1,
                      suffixIcon: IconButton(
                        onPressed: () => cubit.changeVisibility1(),
                        icon: Icon(state.isVisible1 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        color: Colors.grey,
                      ),
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.confirmPasswordController,
                      hintText: 'Enter Confirm password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter confirm password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      isVisiblePassword: state.isVisible2,
                      suffixIcon: IconButton(
                        onPressed: () => cubit.changeVisibility2(),
                        icon: Icon(state.isVisible2 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        color: Colors.grey,
                      ),
                    ),
                    const Gap(Spacing.normal),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            state.otp ?? '',
                            style: const TextStyle(
                              color: Color(0xFF1e6a72),
                              fontStyle: FontStyle.italic,
                              fontSize: TextSize.largeHHeading,
                            ),
                          ),
                        ),
                        Expanded(
                            child: CommonTextField(
                          hintText: 'Enter otp',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter otp';
                            } else if (state.otp != value) {
                              return 'Invalid otp';
                            }
                            return null;
                          },
                          controller: state.otpController,
                        )),
                      ],
                    ),
                    const Gap(Spacing.normal),
                    CommonElevatedButton(
                      onPressed: () => context.read<ForgotPasswordCubit>().loginPasswordPressed(),
                      color: CommonColor.blueColor,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.small)),
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                    const Gap(Spacing.xxxLarge * 4),
                    Row(
                      children: [
                        Expanded(child: Image.asset(AppImages.appstore, height: 50, width: 50, fit: BoxFit.cover)),
                        const Gap(Spacing.normal),
                        Expanded(child: Image.asset(AppImages.playStore, height: 50, width: 50, fit: BoxFit.cover)),
                      ],
                    ),
                    const Gap(Spacing.xxLarge),
                    Row(
                      children: [
                        Image.asset(AppImages.kekaName, height: 30, fit: BoxFit.cover),
                        const Gap(Spacing.normal),
                        const Flexible(
                          child: CommonRichText(
                            listSpan: [
                              LinkTextSpan(
                                  text: 'By logging in,you agree to Keka ', linkStyle: TextStyle(color: Colors.grey)),
                              LinkTextSpan(
                                  text: 'Terms of Use',
                                  linkStyle: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
                              LinkTextSpan(text: ' and ', linkStyle: TextStyle(color: Colors.grey)),
                              LinkTextSpan(
                                  text: 'Privacy Policy',
                                  linkStyle: TextStyle(color: Colors.grey, decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
