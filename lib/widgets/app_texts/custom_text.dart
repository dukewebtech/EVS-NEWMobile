import 'package:flutter/material.dart';

import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

enum AlignPosition{
  start,
  center,
  end,
  
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize = FontSize.s14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = FontWeightManager.regular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomTextUnderLined extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomTextUnderLined(
      {Key? key,
        required this.text,
        this.fontSize = FontSize.s14,
        this.textColor = const Color.fromRGBO(133, 133, 133, 1),
        this.fontWeight = FontWeightManager.regular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getDecoratedTextStyle(fontSize: fontSize, textColor: textColor),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomTextNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const CustomTextNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = FontSize.s14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = FontWeightManager.regular,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end" ? TextAlign.end : alignment == "center" ? TextAlign.center : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}

class CustomTextWithLineHeight extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  final bool alignCenter;
  const CustomTextWithLineHeight(
      {Key? key,
      required this.text,
      this.fontSize = FontSize.s14,
      this.lineHeight = 1.5,
      this.textColor = const  Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = FontWeightManager.regular,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      // overflow: TextOverflow.ellipsis,
    );
  }
}
