import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

class SettingsItem extends StatelessWidget {
  final String iconName;
  final String itemName;
  final VoidCallback onTap;
  const SettingsItem({Key? key, required this.onTap, required this.iconName, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(iconName, color: const Color.fromRGBO(20, 24, 31, 1),),
                  SizedBox(width: AppSize.s20.w,),
                  CustomText(text: itemName, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16, textColor: const Color.fromRGBO(40, 40, 40, 1),),
                ],
              ),

              const Icon(Icons.arrow_forward_ios, color: ColorManager.arrowColor,)

            ],
          ),

          SizedBox(height: AppSize.s24.h,),
          Image.asset(AppImages.divider),
        ],
      ),
    );
  }
}
