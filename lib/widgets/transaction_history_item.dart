import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/transaction_history_api_model.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import 'app_texts/custom_text.dart';

class TransactionHistoryItem extends StatelessWidget {
  final TransactionHistoryData transaction;
  const TransactionHistoryItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(AppImages.bitCoinIcon),
          title: CustomTextWithLineHeight(
            text: transaction.type,
            textColor: ColorManager.arrowColor,
            fontWeight: FontWeightManager.bold,),
          subtitle: CustomTextWithLineHeight(
            text: transaction.state,
            textColor: ColorManager.orangeColor,
            fontWeight: FontWeightManager.light,
          ),
          trailing: Column(
            children: [
              CustomTextWithLineHeight(
                text: "${transaction.value} BTC",
                textColor: ColorManager.lightTextColor,
                fontWeight: FontWeightManager.regular,),
              CustomTextWithLineHeight(
                text: "${transaction.createdAt!.hour}:${transaction.createdAt!.minute}",
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
