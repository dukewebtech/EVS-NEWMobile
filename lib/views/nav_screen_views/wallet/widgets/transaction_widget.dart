import 'package:evs_pay_mobile/model/transaction_history_api_model.dart';
import 'package:evs_pay_mobile/view_models/wallet_transaction_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/value_manager.dart';
import '../../../../widgets/app_texts/custom_text.dart';
import '../../../../widgets/re_usable_widgets.dart';
import '../../../../widgets/transaction_history_item.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionViewModel = context.watch<WalletViewModel>();
    if (transactionViewModel.transactions.isEmpty) {
      if (transactionViewModel.loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (transactionViewModel.error) {
        return Center(
            child: errorDialog(size: 20, tradeViewModel: transactionViewModel)
        );
      }
    }
    return Expanded(
        child: Container(
          color: ColorManager.whiteColor,
          child: transactionViewModel.transactions.isEmpty ?
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.s20.h,
                ),
                Center(
                    child: SvgPicture.asset("assets/images/empty_state.svg")
                ),
                SizedBox(
                  height: AppSize.s49.h,
                ),

                const CustomText(text:
                "No transaction history",
                  textColor: ColorManager.blckColor,
                  fontSize: FontSize.s16,),
                SizedBox(
                  height: AppSize.s8.h,
                ),

                // SizedBox(
                //     width: AppSize.s208.w,
                //     child: const CustomTextNoOverFlow(
                //         alignment: "center",
                //         fontSize: FontSize.s13,
                //         text: AppStrings.transferFundsTo))
              ],
            ),
          ) : ListView.builder(
              itemCount: transactionViewModel.transactions.length + (transactionViewModel.isLastPage ? 0 : 1),
              itemBuilder: (context, index){
                if (index == transactionViewModel.transactions.length - transactionViewModel.nextPageTrigger) {
                  if(transactionViewModel.transactionHistoryModel!.links!.next != null){
                    transactionViewModel.url = transactionViewModel.transactionHistoryModel!.links!.next?? '';
                    transactionViewModel.fetchTransactions();
                  }else{
                    print("Gotten to the end");
                  }

                }
                if (index == transactionViewModel.transactions.length) {
                  if (transactionViewModel.error) {
                    return Center(
                        child: errorDialog(size: 15, tradeViewModel: transactionViewModel)
                    );
                  } else {
                    return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.s200.h
                          ),
                          child: const CupertinoActivityIndicator(),
                        ));
                  }
                }
                final TransactionHistoryData transaction = transactionViewModel.transactions[index];
                return TransactionHistoryItem(transaction: transaction);
              }),
        ));
  }
}

Widget errorDialog({required double size, required WalletViewModel tradeViewModel}){
  return SizedBox(
    height: 180,
    width: 200,
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('An error occurred when fetching the posts.',
          style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
        const SizedBox(height: 10,),
        CustomElevatedButton(onTap: (){

        }, backgroundColor: ColorManager.primaryColor,
            textColor: ColorManager.whiteColor,
            title: "Retry"),
      ],
    ),
  );
}
