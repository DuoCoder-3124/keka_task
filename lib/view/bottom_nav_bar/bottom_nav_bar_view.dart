import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keka_task/common_widget/bottom_navigation.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_cubit.dart';
import 'package:keka_task/view/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:keka_task/view/home/home_view.dart';
import 'package:keka_task/view/inbox/inbox_view.dart';
import 'package:keka_task/view/leave/leave_view.dart';
import 'package:keka_task/view/profile/profle_view.dart';

class BottomNavBarViewArgument {
  // final String? userCode;
  final BottomNavigationOption bottomNavigationOption;

  const BottomNavBarViewArgument({
    // required this.userCode,
    required this.bottomNavigationOption,
  });
}

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  static const String routeName = '/main_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => BottomNavBarCubit(BottomNavBarState(
        navigationOption: args is BottomNavBarViewArgument
            ? args.bottomNavigationOption
            : BottomNavigationOption.home,
      )),
      child: const BottomNavBarView(),
    );
  }

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  BottomNavBarCubit get cubit => BlocProvider.of<BottomNavBarCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocSelector<BottomNavBarCubit, BottomNavBarState, BottomNavigationOption>(
        selector: (state) => state.navigationOption,
        builder: (context, selectTab) {
          return BottomNavBar(
            selectedTab: selectTab,
            onTabChanged: cubit.onTabChange,
          );
        },
      ),
      body: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          final child = switch (state.navigationOption) {
            BottomNavigationOption.leave => LeaveView.builder(context),
            BottomNavigationOption.inbox => InboxView.builder(context),
            BottomNavigationOption.profile => ProfileView.builder(context),
           _ => HomeView.builder(context),
          };
          return PopScope(
            canPop: state.navigationOption == BottomNavigationOption.home,
            child: child,
          );
        },
      ),
    );
  }
}

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
