import 'package:fan_technical_test/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:fan_technical_test/presentation/screens/list_user_screen.dart';
import 'package:fan_technical_test/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidget = [
      const ListUserScreen(),
      const ProfileScreen(),
    ];

    void bottomNavIndexChange(int index) {
      context.read<DashboardBloc>().add(
            IndexBottomNavChange(newIndex: index),
          );
    }

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, buttonNav) {
      return Scaffold(
        body: listWidget[buttonNav.indexBottomNav],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon/fill/users.svg",
                height: 24.0,
              ),
              activeIcon: SvgPicture.asset(
                "assets/icon/light/users.svg",
                height: 24.0,
              ),
              // Wait Localization
              label: 'List Users',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon/fill/user.svg",
                height: 24.0,
              ),
              activeIcon: SvgPicture.asset(
                "assets/icon/light/user.svg",
                height: 24.0,
              ),
              // Wait Localization
              label: 'Profile',
            ),
          ],
          currentIndex: buttonNav.indexBottomNav,
          onTap: bottomNavIndexChange,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
        ),
      );
    });
  }
}
