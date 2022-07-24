import 'package:flutter/material.dart';

class ColorManager {
  static const primaryColor = Color.fromRGBO(255, 220, 24, 1);
  static const accentColor = Color.fromRGBO(204, 176, 19, 1);
  static const greyColor = Color.fromRGBO(130, 130, 130, 1);
  static const greyTextColor = Color.fromRGBO(151, 151, 151, 1);
  static const buttonSplashColor = Color.fromRGBO(255, 220, 24, 1);
  static const blackTextColor = Color.fromRGBO(47, 40, 30, 1);
  static const semiBlackTextColor = Color.fromRGBO(84, 72, 55, 1);
  static const textFieldColor = Color.fromRGBO(46, 56, 77, 1);
  static const inactiveInputFieldColor =  Color.fromRGBO(224, 231, 255, 1);
  static const labelTextColor = Color.fromRGBO(140, 152, 169, 1);
  static const arrowColor =   Color.fromRGBO(133, 133, 133, 1);
  static const greenColor = Color.fromRGBO(93, 248, 136, 1);
  static const blueColor = Color.fromRGBO(37, 123, 206, 1);
  static const orangeColor = Color.fromRGBO(247, 147, 26, 1);
  static const blackTxtColor = Color.fromRGBO(40, 40, 40, 1);
  static const verifyContainerColor = Color.fromRGBO(252, 253, 249, 1);
  static const blckColor = Color.fromRGBO(0, 0, 0, 1);
  static const filterGreyColor = Color.fromRGBO(245, 245, 245, 1);
  static const inputFieldBorder = Color.fromRGBO(240, 240, 240, 1);
  static const lemonGreen = Color.fromRGBO(28, 209, 161, 1);
  static const deepGreenColor = Color.fromRGBO(50, 116, 69, 1);


  static Color lightTextColor = HexColor.fromHex("#657B9A");
  static Color whiteColor = HexColor.fromHex("#FFFFFF");
  static Color containerShadow = HexColor.fromHex("#2C3A4E14");
  static Color disabledButtonColor = HexColor.fromHex("#ABC4ED");
  static Color cardColor = HexColor.fromHex("#F3F4F7");
  static Color filledInputColor = HexColor.fromHex("#EEF3FB");
  static Color hintColor = HexColor.fromHex("#C1CAD7");
  static Color labelColor = HexColor.fromHex("#657B9A");
  static Color errorColor = const Color.fromRGBO(240, 62, 61, 1);
  static Color backButtonColor = HexColor.fromHex("#EEF3FB");
  static Color inputBorderColor = HexColor.fromHex("#E0E4EB");
  static Color faintTextColor = HexColor.fromHex("#8495AE");
  static Color fbBlueColor = HexColor.fromHex("#1977F3");
  static Color visitedPagesColor = HexColor.fromHex("#031F4C");
  static Color redColor = HexColor.fromHex("#FF0000");
  static Color blackColor = HexColor.fromHex("#031F4C");
  static Color dashboardItemsLightColor = HexColor.fromHex("#CCDCF4");
  static Color boldVtuBgColor = HexColor.fromHex("#F2EFFA");
  static Color boldVtuIconContainerColor = HexColor.fromHex("#4C30A0");
  static Color boldSecureVpnContainerColor = HexColor.fromHex("#ED7D31");
  static Color boldSecureVpnBgColor = HexColor.fromHex("#FDF3EC");
  static Color sendToCardColor = HexColor.fromHex("#173F82");

  static Color colorRed = const Color.fromRGBO(204, 51, 79, 1);

  static Color redeemContainerColor = HexColor.fromHex("#F3EEFC");
  static Color redeemPrimaryTextColor = HexColor.fromHex("#290F57");

  static Color payCardColor = HexColor.fromHex("#FAF3EF");
  static Color payTextPrimaryColor = HexColor.fromHex("#4E2C18");

  static Color sendContainerColor = HexColor.fromHex("#E9FBEB");
  static Color sendPrimaryText = HexColor.fromHex("#105618");

  static Color donateCardColor = HexColor.fromHex("#EEF3FB");
  static Color donatePrimaryTextColor = HexColor.fromHex("#0F2957");

  static Color boldAppsItemsOverlay1 = const Color.fromRGBO(0, 0, 0, 0.6);
  static Color boldAppsItemsOverlay2 = const Color.fromRGBO(0, 0, 0, 0);

  static Color settingsSpaceColor = HexColor.fromHex("#E5E5E5");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", '');

    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
