import 'dart:async';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/attendance_request.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:table_calendar/table_calendar.dart';

part 'home_cubit.dart';

part 'home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home_view';

  static Widget builder(BuildContext context) {
    //final args = ModalRoute.of(context)?.settings.arguments;
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
        foregroundColor: CommonColor.white,
        title: CommonText(
          text: 'Home',
          color: CommonColor.white,
          fontWeight: FontWeight.bold,
          fontSize: TextSize.largeHHeading,
        ),
        backgroundColor: CommonColor.blue,
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
                  const Gap(Spacing.small),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 5),
                    child: CommonText(
                      text: 'Actions',
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.heading,
                    ),
                  ),

                  const Gap(Spacing.small),

                  ///1. for clock in & clock out card
                  Card(
                    elevation: 20,
                    child: CommonContainer(
                      color: CommonColor.color1,
                      borderRadius: 5,
                      borderWidth: 0.6,
                      borderColor: CommonColor.color1,
                      padding: PaddingValue.xMedium,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          /// timer
                          Column(
                            children: [

                              ///count-up timer
                              CommonContainer(
                                color: CommonColor.color1,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 3,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height / 19,
                                borderRadius: 5,
                                borderWidth: 0.6,
                                borderColor: Colors.grey,
                                child: Center(
                                  child: CommonText(
                                    text: state.currentTime,
                                    color: CommonColor.white,
                                    fontSize: TextSize.heading,
                                    fontWeight: TextWeight.medium,
                                    textAlign: TextAlign.center,
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
                                  AlignedTooltip(
                                    showDuration: const Duration(seconds: 20),
                                    backgroundColor: Colors.black,
                                    content: Padding(
                                      padding: PaddingValue.small,
                                      child: CommonText(
                                        text:
                                        'These hours are calculated w.r.t Web and forgot id clock-ins/outs for the current day only. Bio-metric clock-ins are not considered.',
                                        color: CommonColor.white,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 15.0,
                                      color: CommonColor.grey,
                                    ),
                                  )
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
                                padding: PaddingValue.medium,
                                onPressed: () {
                                  cubit.getCurrentTime(
                                      timeStartStop: !(state.timeStartStop));
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

                  const Gap(Spacing.xLarge),

                  ///2. Attends state
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: 5),
                    child: CommonText(
                      text: 'Attendance Stats',
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.heading,
                    ),
                  ),

                  const Gap(Spacing.small),
                  Card(
                    elevation: 20,
                    child: CommonContainer(
                      borderRadius: 5,
                      borderWidth: 0.6,
                      color: CommonColor.color1,
                      borderColor: CommonColor.color1,
                      child: Padding(
                        padding: PaddingValue.small,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      cubit.dropDownItemUpdate(
                                          dropDownItem: val);
                                      print('in valu ----> $val');
                                    }),

                                /// info icon button
                                AlignedTooltip(
                                  showDuration: const Duration(seconds: 20),
                                  backgroundColor: CommonColor.black,
                                  content: Padding(
                                    padding: PaddingValue.small,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          text:
                                          'From Feb 19, 2024 to Feb 25, 2024',
                                          color: CommonColor.white,
                                          fontWeight: TextWeight.bold,
                                        ),
                                        const Gap(Spacing.small),
                                        CommonText(
                                          text: 'Total effective Hours: 42:15',
                                          color: CommonColor.white,
                                        ),
                                        CommonText(
                                          text: 'Working Days: 5',
                                          color: CommonColor.white,
                                        ),
                                        CommonText(
                                          text:
                                          'Average Effective Hours: 8h 26m',
                                          color: CommonColor.white,
                                        ),
                                        const Gap(Spacing.small),
                                        CommonText(
                                          text:
                                          "'My Team' refers to all employees reporting to you, as well as those employees reporting(along with you) to your reporting manager.",
                                          color: CommonColor.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: CommonColor.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            const Gap(Spacing.small),

                            ///me, avg hrs/day, on time arriver
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Gap(Spacing.small),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                          Colors.yellow.shade700,
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
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: "AVG HRS / DAY",
                                      color: CommonColor.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: TextSize.content,
                                    ),
                                    CommonText(
                                      text: "8h 13m",
                                      color: CommonColor.white,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: "ON TIME ARRIVAL",
                                      color: CommonColor.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: TextSize.content,
                                    ),
                                    CommonText(
                                      text: "100%",
                                      color: CommonColor.white,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// ***************** Logs & Request ***********************
                  const Gap(Spacing.xLarge),

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
                            const CommonText(
                              text: '24 hour format',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///4. attendance log , shift schedule & attendance request
                  const Gap(Spacing.small),
                  Card(
                    elevation: 10,
                    child: CommonContainer(
                      color: CommonColor.color1,
                      borderRadius: 5,
                      borderWidth: 0.6,
                      padding: PaddingValue.small,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: MaterialButton(
                              color: state.logNRequestClickIndex == 0
                                  ? const Color(0xff3f4b65)
                                  : null,
                              onPressed: () => cubit.getIndex(index: 0),
                              child: AutoSizeText(
                                'Attendance Log',
                                maxLines: 2,
                                style: TextStyle(
                                  color: CommonColor.white,
                                  fontSize: TextSize.label,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          Flexible(
                            child: MaterialButton(
                              color: state.logNRequestClickIndex == 1
                                  ? const Color(0xff3f4b65)
                                  : null,
                              onPressed: () => cubit.getIndex(index: 1),
                              child: AutoSizeText(
                                'Shift Schedule',
                                maxLines: 2,
                                style: TextStyle(
                                  color: CommonColor.white,
                                  fontSize: TextSize.label,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                         /* Flexible(
                            child: MaterialButton(
                              color: state.logNRequestClickIndex == 2
                                  ? const Color(0xff3f4b65)
                                  : null,
                              onPressed: () => cubit.getIndex(index: 2),
                              child: AutoSizeText(
                                'Attendance Request',
                                maxLines: 2,
                                style: TextStyle(
                                  color: CommonColor.white,
                                  fontSize: TextSize.label,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),

                  ///5. last 30 days
                  const Gap(Spacing.small),
                  Card(
                    child: CommonContainer(
                      color: CommonColor.color1,
                      borderRadius: 5,
                      borderWidth: 0.6,
                      padding: PaddingValue.small,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          ///last 30 days
                          CommonText(
                            text: 'Last 30 Days',
                            color: CommonColor.white,
                            fontWeight: TextWeight.bold,
                          ),

                          /// 3o days, jan, dec, nov...
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              showMonth(monthName: '30 Days'),
                              showMonth(monthName: 'Jan'),
                              showMonth(monthName: 'Dec'),
                              showMonth(monthName: 'Nov'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  const Gap(Spacing.none),

                  ///6. show date, effective hours, gross hours
                  if (state.logNRequestClickIndex == 1) ...[
                    shiftSchedule()
                  ]
                  /*else if (state.logNRequestClickIndex == 2) ...[
                      attendanceRequest()
                    ] */
                    else
                      ...[
                        attendanceLog(),
                      ],

                  const Gap(15.0)
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  ///show the month 30Days, jan, feb, march
  Widget showMonth({String? monthName}) {
    return CommonContainer(
      borderColor: CommonColor.grey,
      borderWidth: 0.5,
      padding: const EdgeInsetsDirectional.all(4.0),
      child: CommonText(
        text: monthName,
        color: Colors.white,
      ),
    );
  }

  ///when user click on Attendance Log
  Widget attendanceLog() {
    SfRangeValues? sfRangeValues = const SfRangeValues(4.0, 8.0);
    return Card(
      elevation: 10,
      child: Flexible(
        child: CommonContainer(
          borderRadius: 5,
          borderWidth: 0.6,
          color: const Color(0xff3f4b65),
          padding: PaddingValue.small,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Date & Arrival
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(text: 'DATE : Feb 23, Fri',
                      color: Colors.white,
                      fontSize: TextSize.label),
                  CommonText(text: 'ARRIVAL : On Time',
                      color: Colors.white,
                      fontSize: TextSize.label),
                ],
              ),

              ///Effective hours
              const Gap(Spacing.xMedium),
              const CommonText(
                  text: 'EFFECTIVE HOUR : 8h 25m',
                  color: Colors.white,
                  fontSize: TextSize.label),

              /// gross hours & log
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(text: 'GROSS HOURS: 9h 14m',
                      color: Colors.white,
                      fontSize: TextSize.label),
                  Row(
                    children: [
                      const CommonText(
                        text: 'Log : ',
                        color: Colors.white,
                      ),
                      AlignedTooltip(
                        showDuration: const Duration(seconds: 20),
                        backgroundColor: CommonColor.black,
                        content: Padding(
                          padding: PaddingValue.small,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              CommonText(text: 'General Shift (Feb 26)',
                                color: CommonColor.white,),
                              CommonText(text: '9:00 AM - 6:00 PM',
                                color: CommonColor.white,),
                              Divider(color: CommonColor.grey),

                              Row(
                                children: [
                                  IconButton(onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit, color: Colors.blue,),),
                                  const CommonText(text: 'Apply Partial Day',
                                    color: Colors.blue,),
                                ],
                              ),

                              CommonText(text: 'Web Clock In',
                                fontWeight: TextWeight.bold,
                                color: CommonColor.white,),

                              Row(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(onPressed: () {},
                                          icon: const Icon(Icons.circle,
                                              color: Colors.green)),
                                      CommonText(text: '8:34:08 AM',
                                        fontWeight: TextWeight.bold,
                                        color: CommonColor.white,),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(onPressed: () {},
                                          icon: const Icon(
                                              Icons.circle, color: Colors.red)),
                                      CommonText(text: 'MISSING',
                                        fontWeight: TextWeight.bold,
                                        color: CommonColor.white,),
                                    ],
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.green,
                            )),
                      ),
                    ],
                  )

                ],
              ),


              ///ATTENDANCE VISUAL
              SfRangeSliderTheme(
                data: SfRangeSliderThemeData(
                  activeTickColor: Colors.blue,
                  activeMinorTickColor: Colors.blue,
                  inactiveTickColor: Colors.blue,
                  inactiveMinorTickColor: Colors.blue,
                  tickSize: Size(3.0, 12.0),
                  minorTickSize: Size(3.0, 8.0),
                ),
                child:  SfRangeSlider(
                  min: 2.0,
                  max: 10.0,
                  interval: 2,
                  minorTicksPerInterval: 1,
                  showTicks: true,
                  values: sfRangeValues,
                  onChanged: (SfRangeValues newValues){
                    setState(() {
                      sfRangeValues = newValues;
                    });
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  ///when user click on Shift Schedule
  Widget shiftSchedule() {
    return CommonContainer(
        color: const Color(0xff3f4b65),
        padding: PaddingValue.small,
        borderRadius: 5,
        borderWidth: 0.6,
        child: TableCalendar(
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          daysOfWeekHeight: 30,
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white),
          ),
          firstDay: DateTime.utc(2001, 01, 01),
          lastDay: DateTime.utc(2050, 12, 12),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            weekNumberTextStyle: const TextStyle(color: Colors.black),
            weekendTextStyle: const TextStyle(color: Colors.red),
            tablePadding: const EdgeInsets.all(5),
            cellMargin: const EdgeInsets.all(9),
            // holidayDecoration: BoxDecoration(
            //  color: Colors.red ,
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/appstore.png')
            //   )
            // ),
            todayDecoration:
            BoxDecoration(color: Colors.white.withOpacity(0.8)),
            todayTextStyle: const TextStyle(
                color: Colors.indigo, fontWeight: TextWeight.bold),
            tableBorder: TableBorder.all(
              width: 1,
              color: CommonColor.grey,
            ),
          ),
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.white),
            titleCentered: true,
            headerPadding: EdgeInsets.symmetric(horizontal: 30),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            formatButtonVisible: false,
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, event) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CommonText(
                    fontWeight: TextWeight.medium,
                    text: date.day.toString(),
                    color: (DateTime.saturday != date.weekday) &&
                        (DateTime.sunday != date.weekday)
                        ? Colors.white
                        : Colors.red.shade400,
                  ),
                  const Gap(5),
                  Flexible(
                    child: AutoSizeText(
                      // DateTime.saturday == date.weekday ? Colors.red: Colors.green,
                      ((DateTime.saturday != date.weekday) &&
                          (DateTime.sunday != date.weekday))
                          ? '9:00 AM - 6:00 PM'
                          : 'Holiday',
                      maxLines: 2,
                      minFontSize: 5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: TextWeight.medium,
                          color: ((DateTime.saturday != date.weekday) &&
                              (DateTime.sunday != date.weekday))
                              ? Colors.white.withOpacity(0.6)
                              : Colors.red),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  ///when user click on Attendance Request
  /*Widget attendanceRequest() {
    return const Column(
      children: [
        AttendanceRequest(
          text: 'Work From Home / On Duty Requests',
          subText: 'No Work From Home / On Duty Requests Available',
          date: '25 Jan 2024 - 09 Mar 2024',
        ),
        Gap(Spacing.small),
        AttendanceRequest(
          text: 'Regularization Requests',
          subText: 'No Regularization Requests Available',
          date: '25 Jan 2024 - 09 Mar 2024',
        ),
        Gap(Spacing.small),
        AttendanceRequest(
          text: 'Remote Clock in Requests',
          subText: 'No Remote Clock in Requests Available',
          date: '25 Jan 2024 - 09 Mar 2024',
        ),
        Gap(Spacing.small),
        AttendanceRequest(
          text: 'Partial Day Requests',
          subText: 'No Partial Day Requests Available',
          date: '25 Jan 2024 - 09 Mar 2024',
        ),
      ],
    );
  }*/
}