import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_rich_text.dart';
import 'package:keka_task/common_widget/common_text_field.dart';
import 'package:keka_task/view/login/login_cubit.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = '/login_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginState()),
      child: const LoginView(),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: ),
      body: Center(
        child: SingleChildScrollView(
          padding: PaddingValue.normal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login to Keka',
                style: TextStyle(fontSize: TextSize.appBarTitle),
              ),
              const Gap(Spacing.normal),
              CommonTextField(
                hintText: 'Email or Mobile',
                validator: (value) => 'Enter email or mobile',
                isVisiblePassword: false,
                keyboardType: TextInputType.text,
              ),
              const Gap(Spacing.normal),
              CommonElevatedButton(
                onPressed: () => Navigator.pushNamed(context, LoginPasswordView.routeName),
                color: CommonColor.blueColor,
                height: 50,
                width: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.small)),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Gap(Spacing.normal),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Text(' Login with ', style: TextStyle(color: Colors.grey)),
                  Expanded(child: Divider()),
                ],
              ),
              const Gap(Spacing.normal),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 4),
                      decoration: BoxDecoration(border: Border.all(width: 0.6, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.microsoft, height: 20, width: 20, fit: BoxFit.cover),
                          const Text(' Microsoft'),
                        ],
                      ),
                    ),
                  ),
                  const Gap(Spacing.normal),
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 4),
                      decoration: BoxDecoration(border: Border.all(width: 0.6, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.google, height: 30, width: 30, fit: BoxFit.cover),
                          const Text(' Google'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(Spacing.normal),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 4),
                      decoration: BoxDecoration(border: Border.all(width: 0.6, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.keka, height: 30, width: 30, fit: BoxFit.cover),
                          const Text(' keka username'),
                        ],
                      ),
                    ),
                  ),
                  const Gap(Spacing.normal),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const Gap(Spacing.xxxLarge * 2),
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
  }
}
