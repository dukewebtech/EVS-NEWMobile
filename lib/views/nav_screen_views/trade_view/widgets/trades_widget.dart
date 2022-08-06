import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/trade_view_model.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../model/trades_model_api.dart';
import '../../../../widgets/trades_item.dart';


class TradesWidget extends StatelessWidget {
  const TradesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tradeViewModel = context.watch<TradeViewModel>();
    if (tradeViewModel.trades.isEmpty) {
      if (tradeViewModel.loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (tradeViewModel.error) {
        return Center(
            child: errorDialog(size: 20, tradeViewModel: tradeViewModel)
        );
      }
    }
    return Expanded(
        child: ListView.builder(
            itemCount: tradeViewModel.trades.length + (tradeViewModel.isLastPage ? 0 : 1),
            itemBuilder: (context, index){
              if (index == tradeViewModel.trades.length - tradeViewModel.nextPageTrigger) {
                if(tradeViewModel.tradesModel!.links!.next != null){
                  tradeViewModel.url = tradeViewModel.tradesModel!.links!.next?? '';
                  tradeViewModel.fetchTrades();
                }else{
                  // print("Gotten to the end");
                }

              }
              if (index == tradeViewModel.trades.length) {
                if (tradeViewModel.error) {
                  return Center(
                      child: errorDialog(size: 15, tradeViewModel: tradeViewModel)
                  );
                } else {
                  return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSize.s300.h
                        ),
                        child: CupertinoActivityIndicator(),
                      ));
                }
              }
              final TradeData post = tradeViewModel.trades[index];
              return TradeItem(trade: post);
            }));
  }
}


  Widget errorDialog({required double size, required TradeViewModel tradeViewModel}){
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

