import 'package:evs_pay_mobile/model/transaction_history_model.dart';
import 'package:evs_pay_mobile/model/transaction_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import 'app_texts/custom_text.dart';

class TransactionHistoryItem extends StatelessWidget {
  final TransactionHistory transaction;
  const TransactionHistoryItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(transaction.iconName),
          title: CustomTextWithLineHeight(
            text: transaction.type,
            textColor: ColorManager.lightTextColor,
            fontWeight: FontWeightManager.bold,),
          subtitle: CustomTextWithLineHeight(
            text: transaction.status,
            textColor: ColorManager.orangeColor,
            fontWeight: FontWeightManager.light,
          ),
          trailing: Column(
            children: [
              CustomTextWithLineHeight(
                text: transaction.coinValue,
                textColor: ColorManager.lightTextColor,
                fontWeight: FontWeightManager.regular,),
              CustomTextWithLineHeight(
                text: transaction.time,
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
