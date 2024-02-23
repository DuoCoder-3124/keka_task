import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:table_calendar/table_calendar.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: TableCalendar(
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          daysOfWeekHeight: 30,
          firstDay: DateTime.utc(2001, 01, 01),
          lastDay: DateTime.utc(2050, 12, 12),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            weekNumberTextStyle: TextStyle(color: Colors.black),
            weekendTextStyle: TextStyle(color: Colors.red),
            tablePadding: const EdgeInsets.all(5),
            cellMargin: EdgeInsets.all(9),
            // holidayDecoration: BoxDecoration(
            //  color: Colors.red ,
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/appstore.png')
            //   )
            // ),
            todayDecoration: BoxDecoration(color: Colors.indigo),
            tableBorder: TableBorder.all(
              width: 1,
              color: CommonColor.grey,
            ),
          ),
          headerStyle: const HeaderStyle(
              titleCentered: true,
              headerPadding: EdgeInsets.symmetric(horizontal: 30),
              formatButtonVisible: false),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, event) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CommonText(
                    text: date.day.toString(),
                    color: (DateTime.saturday != date.weekday)
                          && (DateTime.sunday != date.weekday)
                        ? Colors.black
                        : Colors.red,
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
                        color: ((DateTime.saturday != date.weekday)
                                && (DateTime.sunday != date.weekday))
                        ? Colors.indigo.withOpacity(0.6)
                        : Colors.red
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// calendarBuilders: CalendarBuilders(
//     // markerBuilder: ,
//     defaultBuilder: (context, date, event) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       // CommonText(text: date.day.toString(), color: Colors.black,),
//       AutoSizeText(
//         date.day.toString(),
//         maxLines: 2,
//         minFontSize: 8.0,
//         maxFontSize: 16.0,
//       ),
//       const AutoSizeText(
//         '9:00 AM - 6:00 AM',
//         maxLines: 2,
//         minFontSize: 8.0,
//         maxFontSize: 16.0,
//       )
//     ],
//   );
// }),
