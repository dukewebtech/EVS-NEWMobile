import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';

class OfferModel{
  final String coinName;
  final String paymentMethod;
  final String nairaValue;
  final String limit;
  String offerType;
  String coinIcon;

  OfferModel({required this.coinName, required this.limit,
    required this.nairaValue, required this.paymentMethod,
  required this.coinIcon, required this.offerType});

}


final List<OfferModel> offers = [
  OfferModel(coinName: "Giacomo",
      limit: "400,000- 900,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
    coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "500,000- 1000,000,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Bitcoin",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.six20N,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.sellLowerCase

  ),

  OfferModel(coinName: "Giacomo",
      limit: "300,000- 800,000 NGN",
      nairaValue: AppStrings.oneK,
      paymentMethod: "Bank transfer",
      coinIcon: AppImages.btcIconSmallBlack, offerType: AppStrings.buyLowerCase

  ),

];