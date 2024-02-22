import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:keka_task/common_attribute/common_colors.dart';
import 'package:keka_task/common_attribute/common_value.dart';
import 'package:keka_task/common_widget/bottom_navigation.dart';
import 'package:keka_task/common_widget/common_container.dart';
import 'package:keka_task/common_widget/common_elevated_button.dart';
import 'package:keka_task/common_widget/common_text.dart';
import 'package:keka_task/common_widget/enum.dart';
import 'package:keka_task/view/home/home_view.dart';
import 'package:keka_task/view/inbox/inbox_view.dart';
import 'package:keka_task/view/leave/leave_view.dart';
import 'package:keka_task/view/login/login_view.dart';
import 'package:keka_task/view/main_view/main_cubit.dart';
import 'package:keka_task/view/main_view/main_state.dart';
import 'package:keka_task/view/profile/profle_view.dart';

class MainViewArgument {
  final String? userCode;
  final BottomNavigationOption bottomNavigationOption;

  const MainViewArgument({
    required this.userCode,
    required this.bottomNavigationOption,
  });
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = '/home_view';

  static Widget builder(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => MainCubit(MainState(
        navigationOption: args is MainViewArgument
            ? args.bottomNavigationOption
            : BottomNavigationOption.home,
      )),
      child: const MainView(),
    );
  }

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainCubit get cubit => BlocProvider.of<MainCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocSelector<MainCubit, MainState, BottomNavigationOption>(
        selector: (state) => state.navigationOption,
        builder: (context, selectTab) {
          return BottomNavBar(
            selectedTab: selectTab,
            onTabChanged: cubit.onTabChange,
          );
        },
      ),
      body: BlocBuilder<MainCubit, MainState>(
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
