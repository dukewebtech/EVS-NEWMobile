import 'package:evs_pay_mobile/model/trade_model.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/trades_item.dart';

class TradeOnMyAdsWidget extends StatelessWidget {
  const TradeOnMyAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: trades.length,
            itemBuilder: (context, index){
              final trade = trades[index];
              return TradeItem(trade: trade);
            }));
  }
}
