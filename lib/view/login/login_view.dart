import 'dart:developer';

import 'package:equatable/equatable.dart';
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
import 'package:keka_task/modal/register_modal.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/services/firebase_helper.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';
import 'package:keka_task/view/register/register_view.dart';

part 'login_cubit.dart';

part 'login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = '/login_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginState(emailController: TextEditingController(), formKey: GlobalKey<FormState>()),
        context,
      ),
      child: const LoginView(),
    );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  @override
  void initState() {
    // ApiService.helper.registerUser(RegisterModel());
    // FirebaseService().connectFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Center(
            child: Form(
              key: state.formKey,
              child: SingleChildScrollView(
                padding: PaddingValue.normal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Login to Keka', style: TextStyle(fontSize: TextSize.appBarTitle)),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.emailController,
                      hintText: 'Email or Mobile',
                      validator: validateEmailAndPhone,
                      isVisiblePassword: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(Spacing.normal),
                    CommonElevatedButton(
                      onPressed: () => context.read<LoginCubit>().loginPressed(),
                      color: CommonColor.blueColor,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.small)),
                      child: const Text('Continue', style: TextStyle(color: Colors.white)),
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
                    const Gap(Spacing.normal),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>Navigator.pushNamed(context, RegisterView.routeName),
                        child: const Text('create an account?',style: TextStyle(color: CommonColor.blueColor),),
                      ),
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
                                text: 'By logging in,you agree to Keka ',
                                linkStyle: TextStyle(color: Colors.grey),
                              ),
                              LinkTextSpan(
                                text: 'Terms of Use',
                                linkStyle: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                              ),
                              LinkTextSpan(text: ' and ', linkStyle: TextStyle(color: Colors.grey)),
                              LinkTextSpan(
                                text: 'Privacy Policy',
                                linkStyle: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                              ),
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
