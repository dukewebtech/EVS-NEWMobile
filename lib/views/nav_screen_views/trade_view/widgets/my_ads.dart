import 'package:evs_pay_mobile/view_models/my_ads_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../resources/color_manager.dart';
import '../../../../widgets/my_offer_item.dart';
import '../../../../widgets/re_usable_widgets.dart';

class MyAdsWidget extends StatelessWidget {
  const MyAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAdsViewModel = context.watch<MyAdsViewModel>();
    if (myAdsViewModel.offers.isEmpty) {
      if (myAdsViewModel.loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (myAdsViewModel.error) {
        return Center(
            child: errorDialog(size: 20, tradeViewModel: myAdsViewModel)
        );
      }
    }
    return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
            itemCount: myAdsViewModel.offers.length,
            itemBuilder: (context, index){
              final myAd = myAdsViewModel.offers[index];
              return MyAdsItem(myAd: myAd);
            }));
  }
}

Widget errorDialog({required double size, required MyAdsViewModel tradeViewModel}){
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
