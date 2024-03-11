import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/view/register/register_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const String routeName = '/profile_view';

  static Widget builder(BuildContext context) {
    //final args = ModalRoute.of(context)?.settings.arguments;
    return const ProfileView();
  }

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterView.routeName);
                print('edit');
              },
              icon: Icon(Icons.edit_note_sharp),
            )
          ],
          foregroundColor: CommonColor.white,
          title: CommonText(
            text: 'Profile',
            color: CommonColor.white,
            fontWeight: FontWeight.bold,
            fontSize: TextSize.largeHHeading,
          ),
          backgroundColor: CommonColor.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: PaddingValue.small,
            child: Column(
              children: [
                ///1st card
                CommonContainer(
                  borderRadius: 5,
                  borderColor: Colors.grey,
                  color: CommonColor.color1,
                  child: Row(
                    children: [
                      CommonContainer(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 3,
                        color: CommonColor.blue,
                        padding: PaddingValue.small,
                        borderRadius: 5,
                        borderWidth: 0.6,
                        child: const Center(
                          child: CommonText(
                            text: 'NS',
                            fontSize: TextSize.largeHHeading,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontWeight: TextWeight.bold,
                          ),
                        ),
                      ),
                      CommonContainer(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 3,
                        padding: PaddingValue.small,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Nehal Shinde
                            CommonText(
                              text: 'Nehal Shinde',
                              color: CommonColor.white,
                              fontSize: TextSize.appBarTitle,
                              fontWeight: TextWeight.medium,
                            ),

                            ///location + mobile number
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: CommonColor.grey,
                                      size: 18,
                                    ),
                                    CommonText(
                                      text: 'Katargam',
                                      color: CommonColor.white,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: CommonColor.grey,
                                      size: 18,
                                    ),
                                    CommonText(
                                      text: '9909127817',
                                      color: CommonColor.white,
                                    )
                                  ],
                                ),
                              ],
                            ),

                            ///gmail
                            Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: CommonColor.grey,
                                  size: 18,
                                ),
                                const Gap(2),
                                Flexible(
                                  child: AutoSizeText(
                                    'nehal.s@elaunchinfotech.in',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: CommonColor.white,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Divider(color: CommonColor.grey, indent: 1),

                            ///job title
                            Row(
                              children: [
                                CommonText(
                                  color: CommonColor.grey,
                                  text: 'JOB TITLE',
                                  fontSize: Spacing.medium,
                                ),
                                CommonText(
                                    color: CommonColor.white,
                                    text: ' : Trainee',
                                    fontSize: Spacing.medium,
                                    fontWeight: TextWeight.medium),
                              ],
                            ),

                            ///department
                            Row(
                              children: [
                                CommonText(
                                  color: CommonColor.grey,
                                  text: 'DEPARTMENT',
                                  fontSize: Spacing.medium,
                                ),
                                CommonText(
                                    color: CommonColor.white,
                                    text: ' : Android/Flutter',
                                    fontSize: Spacing.medium,
                                    fontWeight: TextWeight.medium),
                              ],
                            ),
//
                            ///business unit
                            Row(
                              children: [
                                CommonText(
                                  color: CommonColor.grey,
                                  text: 'BUSINESS UNIT',
                                  fontSize: Spacing.medium,
                                ),
                                Flexible(
                                    child: CommonText(
                                        color: CommonColor.white,
                                        text: ' : ELaunch Solution Pvt.Ltd',
                                        fontSize: Spacing.medium,
                                        fontWeight: TextWeight.medium)),
                              ],
                            ),

                            ///reported by
                            Row(
                              children: [
                                CommonText(
                                  color: CommonColor.grey,
                                  text: 'REPORTED BY',
                                  fontSize: Spacing.medium,
                                ),
                                CommonText(
                                    color: CommonColor.white,
                                    text: ' : Ajay Patel',
                                    fontSize: Spacing.medium,
                                    fontWeight: TextWeight.medium),
                              ],
                            ),

                            ///emp no
                            Row(
                              children: [
                                CommonText(
                                  color: CommonColor.grey,
                                  text: 'EMP NO',
                                  fontSize: Spacing.medium,
                                ),
                                CommonText(
                                    color: CommonColor.white,
                                    text: ' : EL168',
                                    fontSize: Spacing.medium,
                                    fontWeight: TextWeight.medium),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                ///2nd card
                const Gap(Spacing.xLarge),
                CommonContainer(
                  borderRadius: 5,
                  borderColor: Colors.grey,
                  color: CommonColor.color1,
                  padding: PaddingValue.small,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Primary Details',
                        color: CommonColor.white,
                        fontWeight: TextWeight.extraBold,
                        fontSize: TextSize.appBarSubTitle,
                      ),
                      const Gap(RadiusValue.small),
                      const Divider(
                        height: 1,
                      ),
                      const Gap(RadiusValue.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              text: 'FIRST NAME', color: CommonColor.grey),
                          CommonText(
                              text: 'MIDDLE NAME', color: CommonColor.grey),
                          CommonText(
                              text: 'LAST NAME', color: CommonColor.grey),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonText(text: 'Nehal', color: CommonColor.white),
                          CommonText(
                              text: 'PremendraKumar', color: CommonColor.white),
                          CommonText(text: 'Shinde', color: CommonColor.white),
                        ],
                      ),
                      const Gap(RadiusValue.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              text: 'DISPLAY NAME', color: CommonColor.grey),
                          CommonText(text: 'GENDER', color: CommonColor.grey),
                          CommonText(
                              text: 'DATE OF BIRTH', color: CommonColor.grey),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              text: 'Nehal Shinde', color: CommonColor.white),
                          CommonText(text: 'Male', color: CommonColor.white),
                          CommonText(
                              text: '23 Feb 2003', color: CommonColor.white),
                        ],
                      ),
                    ],
                  ),
                ),
//
                ///3rd card
                const Gap(Spacing.xLarge),
                CommonContainer(
                  borderRadius: 5,
                  borderColor: Colors.grey,
                  color: CommonColor.color1,
                  padding: PaddingValue.small,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Contact Details',
                        color: CommonColor.white,
                        fontWeight: TextWeight.extraBold,
                        fontSize: TextSize.appBarSubTitle,
                      ),
                      const Gap(RadiusValue.small),
                      const Divider(
                        height: 1,
                      ),
                      const Gap(RadiusValue.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              text: 'WORK EMAIL', color: CommonColor.grey),
                          CommonText(
                              text: 'MOBILE NUMBER', color: CommonColor.grey),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonText(
                              text: 'nehal.s@elaunchinfotech.in',
                              color: CommonColor.white),
                          CommonText(
                              text: '9909127817', color: CommonColor.white),
                        ],
                      ),
                    ],
                  ),
                ),


                /// logout user
                const Gap(Spacing.xLarge),
                SizedBox(
                  width: MediaQuery.of(context).size.width/4,
                  child: CommonElevatedButton(
                      onPressed: (){},
                       shape: const RoundedRectangleBorder(
                         borderRadius: ShapeBorderRadius.small
                       ),
                      child: CommonText(text: 'LogOut',color: CommonColor.white)
                  ),
                )

              ],
            ),
          ),
        ));
  }
}
