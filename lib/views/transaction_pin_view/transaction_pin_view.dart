import 'dart:async';

import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/utils/local_notification_service.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TransactionPinView extends StatefulWidget {
  final String walletAddres, description;
  final double amount;

  const TransactionPinView(
      {required this.amount,
      required this.description,
      required this.walletAddres,
      Key? key})
      : super(key: key);

  @override
  State<TransactionPinView> createState() => _TransactionPinViewState();
}

class _TransactionPinViewState extends State<TransactionPinView> {
  late StreamController<ErrorAnimationType> errorController;
  TextEditingController passwordController = TextEditingController();
  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {}
  }

  late final LocalNotificationService service;
  void listenToNotification() {
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  String currentText = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    final evs = context.watch<EvsPayViewModel>();
    final authProvider = context.watch<AuthenticationProvider>();

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: evsPayCustomAppBar(context, AppStrings.back, leadingTap: () {
        Navigator.pop(context);
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.s40.h,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: AppSize.s25.w, right: AppSize.s25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: AppSize.s287.w,
                          child: const CustomTextWithLineHeight(
                            text: 'Transaction Details',
                            textColor: ColorManager.blackTextColor,
                            fontSize: FontSize.s30,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        SizedBox(
                            child: CustomTextWithLineHeight(
                          text: 'This is a breakdown of your transaction ',
                          textColor: ColorManager.semiBlackTextColor,
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s14,
                        )),
                      ],
                    ),

                    SizedBox(
                      height: AppSize.s40.h,
                    ),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Card(
                        elevation: 0.5,
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 0, top: 0, right: 0),
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 11,
                                left: 8,
                                child: Text(
                                  'Id:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 8,
                                child: Text(
                                  widget.walletAddres,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff969696),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Positioned(
                                left: 8,
                                top: 35,
                                child: Text(
                                  'Amount:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 35,
                                right: 8,
                                child: Text(
                                  widget.amount.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff312DA3),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Positioned(
                                left: 8,
                                top: 60,
                                child: Text(
                                  'Description:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 60,
                                child: Text(
                                  widget.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lexend',
                                    color: Color(0xff969696),
                                  ),
                                ),
                              ),
                              // Text(
                              //   "NGN ${dashboardViewModel.createOfferModel.maxAmount ?? "kay"}",
                              //   style: const TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w400,
                              //     fontFamily: 'Lexend',
                              //     color: Color(0xff8e8e8e),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    CustomTextWithLineHeight(
                      text: 'Enter Password to conclude trade',
                      textColor: ColorManager.lightTextColor,
                      fontWeight: FontWeightManager.light,
                      fontSize: FontSize.s15,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabled: true,
                        errorStyle: TextStyle(color: Colors.red),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        hintText: 'Enter Password',
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter password';
                        }
                        if (value.length < 8) {
                          return 'password should not be less than 8 characters';
                        }
                        return null;
                      },
                    ),

                    // S
                    SizedBox(
                      height: AppSize.s50.h,
                    ),
                    Consumer<EvsPayViewModel>(builder: (ctx, auth, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: auth.resMessage,
                              backgroundColor: ColorManager.primaryColor,
                            ),
                          );

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                      return CustomElevatedButton(
                          onTap: () async {
                            //  Perform login here
                            if (_formKey.currentState!.validate()) {
                              auth.sendBTC(
                                  context: context,
                                  walletAdresss: widget.walletAddres.trim(),
                                  amount: widget.amount,
                                  password: passwordController.text,
                                  description: widget.description);
                              await service.showNotification(
                                  id: 1,
                                  title: "Send BTC",
                                  body:
                                      "Dear ${authProvider.userData.user?.username} you have succeessfully sent ${widget.amount} to wallet:id ${widget.walletAddres} ");
                            } else {
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.info(
                                  message: 'please enter password',
                                  backgroundColor: ColorManager.primaryColor,
                                ),
                              );
                            }
                          },
                          backgroundColor: ColorManager.primaryColor,
                          textColor: ColorManager.blackTextColor,
                          title: AppStrings.login.toUpperCase());
                    }),
                    CustomElevatedButton(
                        onTap: () {
                          //  route to confirm transaction screen
                          // openConfirmTransactionPin(context);
                          if (_formKey.currentState!.validate()) {
                            var ho = evs
                                .sendBTC(
                                    context: context,
                                    walletAdresss: widget.walletAddres.trim(),
                                    amount: widget.amount,
                                    password: passwordController.text,
                                    description: widget.description)
                                .catchError((e) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.info(
                                  message: e.toString(),
                                  backgroundColor: ColorManager.primaryColor,
                                ),
                              );
                            }).then((value) => showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Basic dialog title'),
                                          content: const Text(
                                              'TRANSACTION SUCCESSFUL'),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('Disable'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('Enable'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ));
                          }

                          service.showNotification(
                              id: 1,
                              title: "Send BTC",
                              body:
                                  "Dear ${authProvider.userData.user?.username} you have succeessfully sent ${widget.amount} to wallet:id ${widget.walletAddres} ");
                        },
                        backgroundColor: ColorManager.primaryColor,
                        textColor: ColorManager.blackTextColor,
                        title: AppStrings.send.toUpperCase()),

                    SizedBox(
                      height: AppSize.s18.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
