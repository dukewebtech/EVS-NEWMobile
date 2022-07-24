import 'package:evs_pay_mobile/model/trade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import 'app_texts/custom_text.dart';

class TradeOnMyAdItem extends StatelessWidget {
  final TradeModel trade;
  const TradeOnMyAdItem({Key? key, required this.trade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: CustomTextWithLineHeight(
            text: trade.type,
            textColor: ColorManager.lightTextColor,
            fontWeight: FontWeightManager.bold,),
          subtitle: CustomTextWithLineHeight(
            text: trade.status,
            textColor: ColorManager.orangeColor,
            fontWeight: FontWeightManager.light,
          ),
          trailing: Column(
            children: [
              CustomTextWithLineHeight(
                text: trade.coinValue,
                textColor: ColorManager.lightTextColor,
                fontWeight: FontWeightManager.regular,),
              CustomTextWithLineHeight(
                text: trade.time,
                textColor: ColorManager.lightTextColor,
                fontWeight: FontWeightManager.regular,),
            ],
          ),
        ),
        SvgPicture.asset(AppImages.walletDivider),
      ],
    );
  }
}
