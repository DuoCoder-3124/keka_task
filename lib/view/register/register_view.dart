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
import 'package:keka_task/model/register_modal.dart';
import 'package:keka_task/services/api_helper.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:keka_task/view/login_password/login_password_view.dart';

part 'register_state.dart';

part 'register_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static String routeName = '/register_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        RegisterState(
          emailController: TextEditingController(),
          formKey: GlobalKey<FormState>(),
          firstNameController: TextEditingController(),
          middleNameController: TextEditingController(),
          lastNameController: TextEditingController(),
          passwordController: TextEditingController(),
          departmentController: TextEditingController(),
          dobController: TextEditingController(),
          genderController: TextEditingController(),
          jobTitleController: TextEditingController(),
          phoneNumberController: TextEditingController(),
          reportedByController: TextEditingController(),
        ),
        context,
      ),
      child: const RegisterView(),
    );
  }

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: CommonColor.white,
      //   title: Text(
      //     'Register to keka',
      //     style: TextStyle(color: CommonColor.white, fontWeight: FontWeight.bold, fontSize: TextSize.largeHHeading),
      //   ),
      //   backgroundColor: CommonColor.blue,
      // ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          var cubit = context.read<RegisterCubit>();

          return Center(
            child: Form(
              key: state.formKey,
              child: SingleChildScrollView(
                padding: PaddingValue.normal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(Spacing.xLarge),
                    const Text(
                      'Register to Keka',
                      style: TextStyle(fontSize: TextSize.largeHHeading, fontWeight: FontWeight.bold),
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.firstNameController,
                      hintText: 'Enter first name',
                      validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.middleNameController,
                      hintText: 'Enter middle name',
                      validator: (value) => value!.isEmpty ? 'Enter middle name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.lastNameController,
                      hintText: 'Enter last name',
                      validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.emailController,
                      hintText: 'Enter email',
                      validator: validateEmailAndPhone,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.phoneNumberController,
                      hintText: 'Enter Mobile',
                      validator: (value) => value!.isEmpty ? 'Enter mobile number' : null,
                      keyboardType: TextInputType.phone,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.departmentController,
                      hintText: 'Enter department name',
                      validator: (value) => value!.isEmpty ? 'Enter department name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.genderController,
                      hintText: 'Enter gender',
                      validator: (value) => value!.isEmpty ? 'Enter gender' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.dobController,
                      hintText: 'Enter dob',
                      validator: (value) => value!.isEmpty ? 'Enter dob' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.reportedByController,
                      hintText: 'Enter reportedBy person name',
                      validator: (value) => value!.isEmpty ? 'Enter reportedBy name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.jobTitleController,
                      hintText: 'Enter jobTitle name',
                      validator: (value) => value!.isEmpty ? 'Enter jobTitle name' : null,
                      keyboardType: TextInputType.text,
                    ),
                    const Gap(Spacing.normal),
                    CommonTextField(
                      controller: state.passwordController,
                      hintText: 'Enter password',
                      validator: (value) => value!.isEmpty ? 'Enter password' : null,
                      keyboardType: TextInputType.text,
                      isVisiblePassword: true,
                    ),
                    const Gap(Spacing.normal),
                    CommonElevatedButton(
                      onPressed: () => context.read<RegisterCubit>().registerPressed(),
                      color: CommonColor.blueColor,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.small)),
                      child: const Text('Register', style: TextStyle(color: Colors.white)),
                    ),
                    const Gap(Spacing.normal),
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
