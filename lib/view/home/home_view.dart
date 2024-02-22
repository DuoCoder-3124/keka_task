import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';

part 'home_cubit.dart';

part 'home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => HomeCubit(const HomeState()),
      child: const HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'Home',
          color: CommonColor.white,
          fontWeight: FontWeight.bold,
          fontSize: TextSize.largeHHeading,
        ),
        backgroundColor: CommonColor.indigo,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: PaddingValue.small,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ***************** Attendance stats ***********************
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 5),
                    child: CommonText(
                      text: 'Attendance Stats',
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.heading,
                    ),
                  ),

                  const Gap(10),

                  ///1. for clock in & clock out card
                  Card(
                    elevation: 20,
                    child: CommonContainer(
                      borderRadius: 5,
                      borderWidth: 0.6,
                      borderColor: CommonColor.color1,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 15),

                        ///1st card
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// timer
                            Column(
                              children: [
                                ///count-up timer
                                CommonContainer(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height:
                                      MediaQuery.of(context).size.height / 19,
                                  borderWidth: 0.6,
                                  borderColor: Colors.grey,
                                  child: Center(
                                    child: CommonText(
                                      text: state.currentTime,
                                      color: CommonColor.white,
                                      fontSize: TextSize.heading,
                                      fontWeight: TextWeight.medium,
                                    ),
                                  ),
                                ),

                                const Gap(5),

                                ///current date
                                CommonText(
                                  text: state.currentDate,
                                  color: CommonColor.white,
                                  fontSize: TextSize.content,
                                ),

                                ///total hours and info
                                const Gap(8),
                                Row(
                                  children: [
                                    CommonText(
                                      text: 'TOTAL HOURS',
                                      color: CommonColor.grey,
                                      fontSize: TextSize.body,
                                    ),
                                    const Gap(5),
                                    GestureDetector(
                                        onTap: () {
                                          Tooltip(
                                            child: const CommonText(
                                              text: 'nehal',
                                            ),
                                          );
                                          print('click');
                                        },
                                        child: Icon(
                                          Icons.info_outline,
                                          size: 15.0,
                                          color: CommonColor.grey,
                                        ))
                                  ],
                                ),

                                ///effective hours
                                const Gap(2),
                                CommonText(
                                  text: 'Effective: 6h 29m',
                                  color: CommonColor.white,
                                  fontSize: TextSize.content,
                                ),

                                ///gross over
                                const Gap(4),
                                CommonText(
                                  text: 'Gross: 7h 21m',
                                  color: CommonColor.white,
                                  fontSize: TextSize.content,
                                ),
                              ],
                            ),

                            /// web clock out button
                            Column(
                              children: [
                                CommonElevatedButton(
                                  color: CommonColor.red,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                  onPressed: () {
                                    cubit.getCurrentTime();
                                  },
                                  child: CommonText(
                                    text: 'Web Clock-out',
                                    color: CommonColor.white,
                                    fontSize: TextSize.appBarSubTitle,
                                    fontWeight: TextWeight.medium,
                                  ),
                                ),

                                ///since last login
                                const Gap(5),
                                Row(
                                  children: [
                                    CommonText(
                                      text: '1h:55m',
                                      color: CommonColor.white,
                                      fontSize: TextSize.content,
                                    ),
                                    const Gap(4),
                                    CommonText(
                                      text: 'Since Last Login',
                                      color: CommonColor.grey,
                                      fontSize: TextSize.content,
                                    ),
                                  ],
                                ),

                                ///home
                                const Gap(8),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CommonText(
                                    text: 'Work From Home',
                                    color: CommonColor.blueColor,
                                    fontSize: TextSize.content,
                                  ),
                                ),

                                ///on Duty
                                const Gap(1),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CommonText(
                                    text: 'On Duty',
                                    color: CommonColor.blueColor,
                                    fontSize: TextSize.content,
                                  ),
                                ),

                                ///partial day
                                const Gap(1),
                                GestureDetector(
                                  onTap: () {},
                                  child: const CommonText(
                                    text: 'Partial Day',
                                    color: CommonColor.blueColor,
                                    fontSize: TextSize.content,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Gap(15),

                  ///2. Attends state
                  Card(
                    elevation: 20,
                    child: CommonContainer(
                      borderRadius: 5,
                      borderWidth: 0.6,
                      borderColor: CommonColor.color1,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10, bottom: 15, end: 20),
                        child: Column(
                          children: [
                            /// last seen and info button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///drop down button
                                DropdownButton<String>(
                                    items: List.from(state.lastSeen
                                        .map<DropdownMenuItem<String>>(
                                            (String val) {
                                      return DropdownMenuItem<String>(
                                          value: val,
                                          child: CommonText(text: val));
                                    })),
                                    dropdownColor: CommonColor.color2,
                                    borderRadius: BorderRadius.circular(0),
                                    isDense: true,
                                    alignment: Alignment.center,
                                    value: state.dropDownItemValue,
                                    padding: const EdgeInsetsDirectional.all(5),
                                    style: TextStyle(color: CommonColor.white),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: CommonColor.white,
                                    ),
                                    onChanged: (val) {
                                      cubit.dropDownItemUpdate(dropDownItem: val);
                                      print('in valu ----> $val');
                                    }),


                                /// info icon button
                                Tooltip(
                                  message: 'Nehal',
                                  waitDuration: const Duration(milliseconds: 500),
                                  showDuration: const Duration(seconds: 2),
                                  child: IconButton(
                                    onPressed: () {

                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: CommonColor.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            ///me, avg hrs/day, on time arriver
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonText(
                                  text: "AVG HRS / DAY",
                                  color: CommonColor.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: TextSize.content,
                                ),
                                const Gap(17),
                                CommonText(
                                  text: "ON TIME ARRIVAL",
                                  color: CommonColor.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: TextSize.content,
                                )
                              ],
                            ),

                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ///for icon and me
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow.shade700,
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: CommonColor.white,
                                        ),
                                      ),
                                      const Gap(15),
                                      CommonText(
                                        text: "Me",
                                        color: CommonColor.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),

                                  CommonText(
                                    text: "8h 13m",
                                    color: CommonColor.white,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  CommonText(
                                    text: "100%",
                                    color: CommonColor.white,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// ***************** Logs & Request ***********************
                  const Gap(25),

                  ///3.logs & request
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Logs and request
                        const CommonText(
                          text: 'Logs & Request',
                          fontWeight: FontWeight.bold,
                          fontSize: TextSize.heading,
                        ),

                        ///24 hour format
                        Column(
                          children: [
                            FlutterSwitch(
                              value: state.hourFormatOnOff,
                              width: 40,
                              height: 18,
                              toggleSize: 20,
                              padding: 0.0,
                              onToggle: (bool value) {
                                cubit.hourFormatOnOff(isHourFormatOn: value);
                              },
                            ),
                            CommonText(
                              text: '24 hour format',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///4. attendance log , shift schedule & attendance request
                  const Gap(10),
                  CommonContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: AutoSizeText(
                              'Attendance Log',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.white,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: AutoSizeText(
                              'Shift Schedule',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15, color: CommonColor.white),
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: AutoSizeText(
                              'Attendance Request',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15, color: CommonColor.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///5. last 30 days
                  const Gap(10),
                  CommonContainer(
                    padding: const EdgeInsetsDirectional.all(7.0),
                    child: Row(
                      children: [
                        CommonText(
                          text: 'Last 30 Days',
                          color: CommonColor.white,
                          fontWeight: TextWeight.bold,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
