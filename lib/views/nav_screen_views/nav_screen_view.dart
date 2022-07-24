import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/dashboard_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/settings/settings_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/wallet/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/image_manager.dart';
import 'trade_view/trade_view.dart';

class NavScreenView extends StatefulWidget {
  const NavScreenView({Key? key}) : super(key: key);

  @override
  State<NavScreenView> createState() => _NavScreenViewState();
}

class _NavScreenViewState extends State<NavScreenView> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    TradeView(),
    WalletView(),
    SettingsView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorManager.whiteColor,
        enableFeedback: false,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                AppImages.dashboardIcon, color: ColorManager.blackTextColor),
            label: AppStrings.home,
            activeIcon: SvgPicture.asset(
              AppImages.dashboardIcon, color: ColorManager.primaryColor,),
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(AppImages.marketPlaceIcon),
            activeIcon: SvgPicture.asset(
                AppImages.marketPlaceIcon, color: ColorManager.primaryColor),
            label: AppStrings.trade,
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.walletIcon),
            activeIcon: SvgPicture.asset(
                AppImages.walletIcon, color: ColorManager.primaryColor),
            label: AppStrings.wallet,
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.slidersIcon),
            activeIcon: SvgPicture.asset(
                AppImages.slidersIcon, color: ColorManager.primaryColor),
            label: AppStrings.settings,
            backgroundColor: ColorManager.whiteColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: ColorManager.blackTextColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
