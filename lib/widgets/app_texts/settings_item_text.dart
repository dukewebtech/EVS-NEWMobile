import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import 'custom_text.dart';

class SettingsItemText extends StatelessWidget {
  final String text;
  const SettingsItemText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextWithLineHeight(text: text, fontSize: FontSize.s14, textColor: ColorManager.primaryColor,);
  }
}
