import 'package:dots_indicator/dots_indicator.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();

  int initialPage = 0;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (int index){
                  initialPage = index;
                  setState(() {

                  });
                },
                itemBuilder: (context, index) {
                  return ListView(
                    children: [
                      pages[index],
                    ],
                  );
                },
                itemCount: pages.length,
              ),
            ),


            Column(
              children: [
                DotsIndicator(
                  dotsCount: pages.length,
                  position: initialPage.toDouble(),
                  decorator: const DotsDecorator(
                    color: ColorManager.greyTextColor, // Inactive color
                    activeColor: Color.fromRGBO(251, 192, 61, 1),
                  ),
                ),

                SizedBox(height: AppSize.s33.h,),
                CustomElevatedButton(onTap: (){
                  openLoginScreen(context);
                }, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackColor, title: initialPage == 2? AppStrings.finish : AppStrings.clickToContinue),

                SizedBox(height: AppSize.s25.h,),
                initialPage < 2? SizedBox(height: AppSize.s20.h,
                child: InkWell(
                  onTap: (){
                    openLoginScreen(context);
                  },
                    child: const CustomText(text: AppStrings.skip, textColor: ColorManager.greyTextColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s14,)),)
                : Container(),

                SizedBox(height: AppSize.s50.h,)
              ],
            )
          ],
        ),

      ),
    );
  }
}


class PageViewOnBoarding extends StatelessWidget {
  final String? image, title, subtitle;
  const PageViewOnBoarding({
    Key? key,
    this.image,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSize.s100.h),
        Row(
          children: [

            SizedBox(
              height: theme.height * .3,
              width: theme.width * .90,
              child: Image.asset(image!),
            ),
          ],
        ),
        SizedBox(height: 19.h),

        SizedBox(
          width: 287.h,
            child: CustomTextWithLineHeight(
              alignCenter: true,
                text: title!, fontWeight: FontWeightManager.bold, fontSize: FontSize.s24, textColor: const Color.fromRGBO(81, 81, 81, 1),)),
        const SizedBox(height: 7),
        SizedBox(
            width: 283.h,
            child: CustomTextWithLineHeight(
              alignCenter: true,
              text: subtitle!, fontWeight: FontWeightManager.light, fontSize: FontSize.s15, textColor: const Color.fromRGBO(81, 81, 81, 1),)),

      ],
    );
  }
}


final List<Widget> pages = [

  const PageViewOnBoarding(
    title: "Trade Cryptocurrency from anywhere around the world.",
    subtitle: 'EVSpay is an easy, fast, and secure P2P Cryptocurrency trading platform.',
    image: AppImages.onBoarding_1,
  ),
  const PageViewOnBoarding(
    title: "Support",
    subtitle: "We are one click away from helping you.",
    image: AppImages.onBoarding_2,
  ),
  const PageViewOnBoarding(
    title: "Security",
    subtitle: "Your cryptocurrency is secured by our escrow till trade is completed.",
    image: AppImages.onBoarding_3,
  ),
];
