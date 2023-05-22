import 'package:evs_pay_mobile/resources/styles_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //  Main Colors of the app
      primaryColor: ColorManager.primaryColor,
      disabledColor: ColorManager.disabledButtonColor,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: ColorManager.accentColor),

      //  Card Theme
      cardTheme: CardTheme(
          color: ColorManager.cardColor, elevation: AppSize.cardElevation),

      //    AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.whiteColor,
        elevation: AppSize.appBarElevation,
        titleTextStyle:
            getAppBarTitleStyle(textColor: ColorManager.primaryColor),
      ),

      //   Button theme
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
          ),
          buttonColor: ColorManager.primaryColor,
          splashColor: ColorManager.primaryColor),

      //  Elevated button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
      
          style: ElevatedButton.styleFrom(
        textStyle: getAppBarTitleStyle(textColor: ColorManager.whiteColor), backgroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
        ),
        
      )),

      //  Text Theme
      textTheme: TextTheme(
          displayLarge: getBoldStyle(
              textColor: ColorManager.primaryColor, fontSize: FontSize.s24),
          displayMedium: getPageSubtitleStyle(textColor: ColorManager.primaryColor),
          bodyLarge: getRegularStyle(textColor: ColorManager.lightTextColor)),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.contentPadding),
        hintStyle: getHintStyle(textColor: ColorManager.hintColor),
        labelStyle: getHintStyle(textColor: ColorManager.labelColor),
        errorStyle: getHintStyle(textColor: ColorManager.errorColor),
        
      

        //  Enable Borders
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.hintColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.hintColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Focus Borders
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.primaryColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Error Border
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.errorColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),

        //  Focus Error Border
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.errorColor,
              width: AppSize.inputBorderSide,
            ),
            borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius)),
      ));
}
