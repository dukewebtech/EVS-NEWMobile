import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:flutter/cupertino.dart';

class TransactionTypeModel {
  final String title;
  final String slug;
  final Color containerColor;
  final Color textColor;

  TransactionTypeModel(
      {required this.title,
      required this.textColor,
      required this.containerColor,
      required this.slug});
}

final List<TransactionTypeModel> transactionTypes = [
  TransactionTypeModel(
      title: AppStrings.send,
      textColor: const Color(0xffffffff),
      containerColor: const Color(0xff000000).withOpacity(0.8),
      slug: "send"),
  TransactionTypeModel(
      title: AppStrings.receive,
      textColor: const Color(0xffffffff),
      containerColor: const Color(0xff000000).withOpacity(0.8),
      slug: "receive"),
];
