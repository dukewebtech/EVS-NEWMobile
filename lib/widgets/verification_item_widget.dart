import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';

class VerificationItemWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final bool isVerified;
  const VerificationItemWidget(
      {Key? key,
      required this.iconName,
      required this.title,
      required this.subTitle,
      required this.onTap,
      this.isVerified = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            title: CustomTextWithLineHeight(
              text: title,
              textColor: const Color(0xff000000),
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.semiBold,
            ),
            subtitle: CustomTextWithLineHeight(
              text: subTitle,
              textColor: const Color(0xff8B8B8B),
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.medium,
            ),
            trailing: isVerified
                ? const Icon(
                    Icons.check_circle_rounded,
                    color: ColorManager.primaryColor,
                  )
                : null,

            // SvgPicture.asset(isVerified
            //     ? const Icon(Icons.check_box)
            //     : AppImages.verificationForwardArrow),
          ),
          SizedBox(
            height: AppSize.s10.h,
          ),
          Image.asset(AppImages.divider),
        ],
      ),
    );
  }
}
