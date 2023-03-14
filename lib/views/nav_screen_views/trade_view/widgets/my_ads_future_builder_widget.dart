import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/view_models/services/my_ads_service.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../resources/value_manager.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/my_offer_item.dart';

class MyAdsFutureBuilderWidget extends StatefulWidget {
  const MyAdsFutureBuilderWidget({Key? key}) : super(key: key);

  @override
  State<MyAdsFutureBuilderWidget> createState() =>
      _MyAdsFutureBuilderWidgetState();
}

class _MyAdsFutureBuilderWidgetState extends State<MyAdsFutureBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return Expanded (
      child: FutureBuilder<List<OfferData?>>(
          future: MyAdsService().getMyAds(authProvider.userData.accessToken!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error Occurred'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s96.h,
                      ),
                      Center(
                          child: SvgPicture.asset(
                              "assets/images/empty_state.svg")),
                      SizedBox(
                        height: AppSize.s49.h,
                      ),
                      const CustomText(
                        text: AppStrings.youHaveNotCreatedAnyOffer,
                        textColor: ColorManager.blckColor,
                        fontSize: FontSize.s16,
                      ),
                      SizedBox(
                        height: AppSize.s8.h,
                      ),
                      SizedBox(
                          width: AppSize.s208.w,
                          child: const CustomTextNoOverFlow(
                              alignment: "center",
                              fontSize: FontSize.s13,
                              text: AppStrings.transferFundsToYourWallet))
                    ],
                  ),
                );
              } else {
                final offers = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () async {
                    MyAdsService().getMyAds(authProvider.userData.accessToken!);
                  },
                  child: ListView.builder(
                      itemCount: offers.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final offer = offers[index];

                        return MyAdsItem(myAd: offer!);
                      }),
                );
              }
            } else {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: const LoadingIndicator(),
              );
            }
          }),
    );
  }
}
