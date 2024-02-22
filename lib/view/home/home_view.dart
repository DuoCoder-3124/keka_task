import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: 'Home', fontWeight: FontWeight.bold),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              /// for clock in & clock out card
              Card(
                elevation: 20,
                child: CommonContainer(
                  borderWidth: 0.6,
                  borderColor: CommonColor.color1,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// timer
                        Column(
                          children: [
                            ///count-up timer
                            CommonContainer(
                              borderWidth: 0.6,
                              borderColor: Colors.grey,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 15.0, vertical: 6.0),
                              child: CommonText(
                                text: '03:25:49 pm',
                                color: CommonColor.white,
                                fontSize: TextSize.heading,
                                fontWeight: TextWeight.medium,
                              ),
                            ),

                            const Gap(5),

                            ///current date
                            CommonText(
                              text: 'Wed 21, Feb 2024',
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
                                    onTap: () {},
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
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                              onPressed: () {},
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

              ///Attends state
              Card(
                elevation: 20,
                child: CommonContainer(
                  borderWidth: 0.6,
                  borderColor: CommonColor.color1,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 15, horizontal: 7),
                    child: Column(
                      children: [
                        /// last seen and info button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///drop down button
                            DropdownButton<String>(
                                items: List.from(state.lastSeen
                                    .map<DropdownMenuItem<String>>((String val) {
                                  return DropdownMenuItem<String>(
                                      value: val, child: CommonText(text: val));
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
                                  context
                                      .read<HomeCubit>()
                                      .dropDownItemUpdate(dropDownItem: val);
                                  print('in valu ----> $val');
                                }),

                            /// info icon button
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.info_outline,
                                color: CommonColor.grey,
                              ),
                            )
                          ],
                        ),

                        ///me, avg hrs/day, on time arriver
                        Row(
                          children: [
                            ///for icon and me
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
                                fontWeight: FontWeight.w500),

                            ///for avg hrs / day
                            Column(
                              children: [
                                CommonText(
                                  text: 'Since Last Login',
                                  color: CommonColor.grey,
                                  fontSize: TextSize.content,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
