import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: FontSize.s15,
          fontWeight: FontWeightManager.light,
          textColor: ColorManager.labelTextColor,
        ),
      ],
    );
  }
}
