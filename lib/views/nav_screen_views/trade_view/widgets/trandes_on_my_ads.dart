import 'package:evs_pay_mobile/model/trade_model.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/trades_item.dart';

class TradeOnMyAdsWidget extends StatelessWidget {
  const TradeOnMyAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final evsPayProvider = context.watch<EvsPayViewModel>();
    return Expanded(
        child: ListView.builder(
            itemCount: evsPayProvider.trade.trades!.length,
            itemBuilder: (context, index){
              final trade = evsPayProvider.trade.trades![index];
              return TradeItem(trade: trade);
            }));
  }
}
