import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_images.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_rich_text.dart';
import 'package:keka_task/common_widget/common_text_field.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:keka_task/view/forgot_password/forgot_password_view.dart';
import 'package:keka_task/view/home/home_view.dart';

import 'login_password_cubit.dart';

class LoginPasswordView extends StatefulWidget {
  const LoginPasswordView({super.key});

  static String routeName = '/login_password_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPasswordCubit(LoginPasswordState()),
      child: const LoginPasswordView(),
    );
  }

  @override
  State<LoginPasswordView> createState() => _LoginPasswordViewState();
}

class _LoginPasswordViewState extends State<LoginPasswordView> {
  // final uuid = const Uuid();
  // final captcha = const Uuid().v4().substring(1, 5).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginPasswordCubit, LoginPasswordState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: PaddingValue.normal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(Spacing.xxxLarge),
                  Image.asset(AppImages.elaunch, height: 50, width: 50, fit: BoxFit.cover),
                  const Gap(Spacing.normal),
                  const Text(
                    'Login to Keka',
                    style: TextStyle(fontSize: TextSize.appBarTitle),
                  ),
                  const Gap(Spacing.normal),
                  Row(
                    children: [
                      const Text('harshit.r@elaunchinfotech.in'),
                      const Gap(Spacing.small),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.mode_edit_outlined, color: Colors.grey, size: 24),
                      ),
                    ],
                  ),
                  const Gap(Spacing.normal),
                  CommonTextField(
                    hintText: 'Password',
                    validator: (value) => 'Enter password',
                    isVisiblePassword: state.isVisible,
                    suffixIcon: IconButton(
                      onPressed: () => context.read<LoginPasswordCubit>().changeVisibility(),
                      icon: Icon(state.isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      color: Colors.grey,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const Gap(Spacing.normal),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // flex: 4,
                        child: Text(
                          textAlign: TextAlign.center,
                          // uuid.v4().substring(1, 5).toUpperCase(),
                          'N6D4',
                          style: TextStyle(
                              color: Color(0xFF1e6a72), fontStyle: FontStyle.italic, fontSize: TextSize.largeHHeading),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        child: Icon(Icons.refresh, color: CommonColor.blueColor),
                      ),
                      Expanded(
                          // flex: 4,
                          child: CommonTextField(
                        hintText: 'Captcha',
                      )),
                    ],
                  ),
                  const Gap(Spacing.normal),
                  CommonElevatedButton(
                    onPressed: () =>Navigator.pushNamed(context, BottomNavBarView.routeName),
                    color: CommonColor.blueColor,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.small)),
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  const Gap(Spacing.small),
                  TextButton(
                    child: const Text('Forgot password ?', style: TextStyle(color: CommonColor.blueColor)),
                    onPressed: () => Navigator.pushNamed(context, ForgotPasswordView.routeName),
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
          );
        },
      ),
    );
  }
}
