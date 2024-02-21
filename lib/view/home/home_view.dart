import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/view/home/home_cubit.dart';
import 'package:keka_task/view/home/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home_view';

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeState()),
      child: const HomeView(),
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Leave',
              icon: Icon(Icons.exit_to_app),
            ),
            BottomNavigationBarItem(
              label: 'Inbox',
              icon: Icon(Icons.inbox),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          selectedItemColor: CommonColor.indigo,
          unselectedItemColor: CommonColor.grey,
          selectedFontSize: TextSize.subTitle,
          unselectedFontSize: TextSize.subTitle,
          selectedLabelStyle: const TextStyle(fontWeight: TextWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: TextWeight.medium),
          onTap: null,
        ),
        body: CommonContainer(
          height: 157,
          borderColor: CommonColor.color1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// timer
              Column(
                children: [
                  CommonContainer(
                    borderColor: Colors.grey,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 15.0, vertical: 7.0),
                    child: Text(
                      '03:25:49 pm',
                      style: TextStyle(
                          color: CommonColor.white,
                          fontWeight: TextWeight.medium,
                          fontSize: TextSize.heading),
                    ),
                  ),

                  Text(
                    'Wed 21, Feb 2024',
                    style: TextStyle(
                      color: CommonColor.white,
                      fontSize: TextSize.content
                    ),
                  ),

                  ///total hours and info
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        'TOTAL HOURS',
                        style: TextStyle(
                          color: CommonColor.grey,
                          fontSize: TextSize.content
                        ),
                      ),
                      const Gap(5),
                      GestureDetector(
                          onTap: (){},
                          child: Icon(Icons.info_outline,size: 15.0,color: CommonColor.grey,))
                    ],
                  ),


                  ///effective hours
                  const Gap(6),
                  Text(
                    'Effective: 6h 29m',
                    style: TextStyle(
                      color: CommonColor.white,
                      fontSize: TextSize.content
                    ),
                  ),

                  ///gross over
                  const Gap(2),
                  Text(
                    'Gross: 7h 21m',
                    style: TextStyle(
                        color: CommonColor.white,
                        fontSize: TextSize.content
                    ),
                  ),

                ],
              ),

              /// web clock out button
              Column(
                children: [
                  const Gap(8),
                  CommonElevatedButton(
                    color: CommonColor.red,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 18.0, vertical: 12.0),
                    onPressed: (){},
                    child: Text(
                      'Web Clock-out',
                      style: TextStyle(
                          color: CommonColor.white,
                          fontWeight: TextWeight.medium,
                          fontSize: TextSize.appBarSubTitle),
                    ),
                  ),

                  //since last login
                  const Gap(5),
                  Row(
                    children: [
                      Text(
                        '1h:55m',
                        style: TextStyle(
                            color: CommonColor.white,
                            fontSize: TextSize.content
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Since Last Login',
                        style: TextStyle(
                            color: CommonColor.grey,
                            fontSize: TextSize.content
                        ),
                      )
                    ],
                  ),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                      child: Text('home',style: TextStyle(color: Colors.blue),),
                    ),
                  )

                  //work from home
                  // RichText(
                  //     text: TextSpan(
                  //       text: 'home',
                  //       style: TextStyle(color: Colors.blue),
                  //       mouseCursor: MouseCursor.uncontrolled,
                  //       recognizer: TapGestureRecognizer()
                  //           ..onTap = (){
                  //               print('tap');
                  //           }
                  //     ),
                  //)

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Leave',
              icon: Icon(Icons.exit_to_app),
            ),
            BottomNavigationBarItem(
              label: 'Inbox',
              icon: Icon(Icons.inbox),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          selectedItemColor: Common_Colors.color1,
          unselectedItemColor: Common_Colors.color2,
          selectedFontSize: TextSize.subTitle,
          unselectedFontSize: TextSize.subTitle,
          selectedLabelStyle: const TextStyle(fontWeight: TextWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: TextWeight.medium),
          onTap: null,
        ))*/
