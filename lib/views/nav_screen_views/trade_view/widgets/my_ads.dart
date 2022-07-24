import 'package:flutter/material.dart';

import '../../../../model/my_ads_model.dart';
import '../../../../widgets/my_offer_item.dart';

class MyAdsWidget extends StatelessWidget {
  const MyAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
            itemCount: myAds.length,
            itemBuilder: (context, index){
              final myAd = myAds[index];
              return MyAdsItem(myAd: myAd);
            }));
  }
}
