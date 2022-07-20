import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';

class TransactionTypeModel{
  final String title;
  final String slug;
  final Color containerColor;
  final Color textColor;
  
  TransactionTypeModel({required this.title, required this.textColor,
    required this.containerColor, required this.slug});

}


final List<TransactionTypeModel> transactionTypes = [
  TransactionTypeModel(title: AppStrings.send,
      textColor: ColorManager.blackTextColor,
      containerColor: ColorManager.primaryColor,
    slug: "send"
  ),
  TransactionTypeModel(title: AppStrings.receive,
      textColor: ColorManager.whiteColor,
      containerColor: ColorManager.orangeColor,
    slug: "receive"
  ),
];