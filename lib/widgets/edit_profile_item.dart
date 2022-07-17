import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';



class EditProfileItem extends StatelessWidget {
  final String title;
  final String iconName;
  final Color borderColor;
  final Color textColor;
  const EditProfileItem({Key? key, required this.iconName, required this.title, required this.borderColor, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s14.w),
      height: AppSize.s62.h,
      width:  double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
        borderRadius: BorderRadius.circular(AppSize.s3.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, textColor: textColor,),
          SvgPicture.asset(iconName),


        ],
      ),
    );
  }
}
