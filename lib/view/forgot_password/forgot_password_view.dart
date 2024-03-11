import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_attribute/validation.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_rich_text.dart';
import 'package:keka_task/common_widget/common_text_field.dart';
import 'package:keka_task/view/forgot_password/forgot_password_cubit.dart';
import 'package:keka_task/view/login/login_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  static String routeName = '/forgot_password_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        ForgotPasswordState(
            passwordController: TextEditingController(),
            formKey: GlobalKey<FormState>(),
            captchaController: TextEditingController()),
        context,
      ),
      child: const ForgotPasswordView(),
    );
  }

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  // final uuid = const Uuid();
  // final captcha = const Uuid().v4().substring(1, 5).toUpperCase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          var cubit=context.read<ForgotPasswordCubit>();
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
                      hintText: 'Email or Mobile',
                      validator: (value)=>validateEmailAndPhone(value),
                      isVisiblePassword: false,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            // uuid.v4().substring(1, 5).toUpperCase(),
                            // 'N6D4',
                            state.captcha??'',
                            style: TextStyle(
                              color: Color(0xFF1e6a72),
                              fontStyle: FontStyle.italic,
                              fontSize: TextSize.largeHHeading,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: 16),
                          child: IconButton(icon: Icon(Icons.refresh, color: CommonColor.blueColor), onPressed: () =>cubit.refreshCaptcha(),),
                        ),
                        Expanded(
                            child: CommonTextField(
                          hintText: 'Captcha',
                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Enter captcha';
                            }else if(state.captcha!=value){
                              return 'Invalid captcha';
                            }
                            return null;
                          },
                          controller: state.captchaController,
                        )),
                      ],
                    ),
                    const Gap(Spacing.normal),
                    CommonElevatedButton(
                      onPressed: () =>
                          context.read<ForgotPasswordCubit>().loginPasswordPressed(),
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
