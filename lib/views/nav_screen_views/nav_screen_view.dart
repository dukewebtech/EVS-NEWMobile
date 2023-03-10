import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/view_models/nav_screen_view_model.dart';
import 'package:evs_pay_mobile/views/confirm_buy_screen/confirm_buy_screen.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/dashboard_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/trade_view_copy.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/wallet/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import 'package:iconsax/iconsax.dart';

class NavScreenView extends StatefulWidget {
  const NavScreenView({Key? key}) : super(key: key);

  @override
  State<NavScreenView> createState() => _NavScreenViewState();
}

class _NavScreenViewState extends State<NavScreenView> {
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardView(),
    const TradeViewCopy(),
    const WalletView(),
    const ConfirmBuyScreen()
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
            icon: const Icon(Iconsax.home),
            label: AppStrings.home,
            activeIcon: const Icon(
              Iconsax.home,
              color: Color(0xffF4B731),
            ),
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.transaction_minus),
            activeIcon:
                const Icon(Iconsax.transaction_minus, color: Color(0xffF4B731)),
            label: AppStrings.trade,
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.wallet),
            activeIcon: const Icon(
              Iconsax.wallet,
              color: Color(0xffF4B731),
            ),
            label: AppStrings.wallet,
            backgroundColor: ColorManager.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Iconsax.wallet),
            activeIcon: const Icon(
              Iconsax.wallet,
              color: Color(0xffF4B731),
            ),
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
