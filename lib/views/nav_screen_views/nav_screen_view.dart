import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/view_models/nav_screen_view_model.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/dashboard_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/trade_view_copy.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/wallet/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/image_manager.dart';

class NavScreenView extends StatefulWidget {
  const NavScreenView({Key? key}) : super(key: key);

  @override
  State<NavScreenView> createState() => _NavScreenViewState();
}

class _NavScreenViewState extends State<NavScreenView> {

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    TradeViewCopy(),
    WalletView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      context.read<NavScreenViewModel>().updateSelectedPage(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    final navViewModel = context.watch<NavScreenViewModel>();
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Center(
        child: _widgetOptions.elementAt(navViewModel.selectedPage),
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
        ],
        currentIndex: navViewModel.selectedPage,
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: ColorManager.blackTextColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
