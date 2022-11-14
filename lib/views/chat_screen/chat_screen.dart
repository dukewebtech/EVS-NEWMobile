import 'dart:async';

import 'package:evs_pay_mobile/model/user_model/chat_model.dart';
import 'package:evs_pay_mobile/view_models/chats_view_model.dart';
import 'package:evs_pay_mobile/view_models/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../view_models/authentication_view_model/authentication_view_model.dart';
import '../../view_models/services/chats_services.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/loading_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key,}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   Future<List<Chats?>>? _future;
  bool showBottomSheet = true;
  final chatController = TextEditingController();

   final ScrollController _scrollController = ScrollController();

  Future<List<Chats?>> getChats(String token, String tradeReference) async {
    final chats =  ChatService().getChats(token, tradeReference);

    return chats;
  }



  setUpTimedFetch() {
    Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
        final dashboardViewModel = Provider.of<DashboardViewModel2>(context, listen: false);
        setState(() {
          _future = getChats(authProvider.userData.accessToken??"", dashboardViewModel.tradeReference);

          SchedulerBinding.instance.addPostFrameCallback((_) {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 1),
                curve: Curves.fastOutSlowIn);
          });
        });
      });


    });
  }

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();

  }



  
  
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
      final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.buyLowerCase,
          leadingTap: (){
            Navigator.pop(context);
          },
          isCenterAlign: true),
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s20.w
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.s130.h,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  color: ColorManager.primaryColor,
                  border: Border.all(
                      color: ColorManager.inputFieldBorder
                  )
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s10.w
                ),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.s32.h,),

                  // StreamBuilder(
                  //   stream: Stream.periodic(const Duration(seconds: 5))
                  //       .asyncMap((i) => ChatService().getChats(authProvider.userData.accessToken!, dashboardViewModel.tradeReference)), // i is null here (check periodic docs)
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return const Center(child: Text('Error Occurred'));
                  //     } else if (snapshot.hasData) {
                  //       if (snapshot.data == null) {
                  //         return Center(
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                 height: AppSize.s96.h,
                  //               ),
                  //               Center(
                  //                   child: SvgPicture.asset("assets/images/empty_state.svg")
                  //               ),
                  //               SizedBox(
                  //                 height: AppSize.s49.h,
                  //               ),
                  //
                  //               const CustomText(text:
                  //               AppStrings.youHaveNotCreatedAnyOffer,
                  //                 textColor: ColorManager.blckColor,
                  //                 fontSize: FontSize.s16,),
                  //               SizedBox(
                  //                 height: AppSize.s8.h,
                  //               ),
                  //
                  //               SizedBox(
                  //                   width: AppSize.s208.w,
                  //                   child: const CustomTextNoOverFlow(
                  //                       alignment: "center",
                  //                       fontSize: FontSize.s13,
                  //                       text: AppStrings.transferFundsToYourWallet))
                  //             ],
                  //           ),
                  //         );
                  //       } else {
                  //         final offers = snapshot.data!;
                  //         return SizedBox(
                  //           height: MediaQuery.of(context).size.height * 0.55,
                  //           child: ListView.builder(
                  //               itemCount: offers.length,
                  //               physics: const BouncingScrollPhysics(),
                  //               shrinkWrap: true,
                  //               itemBuilder: (context, index) {
                  //                 final chat = offers[index];
                  //
                  //                 return Padding(
                  //                   padding: EdgeInsets.only(
                  //                       bottom: AppSize.s20.h
                  //                   ),
                  //                   child: Row(
                  //                     mainAxisAlignment: chat?.direction == "SEND" ?
                  //                     MainAxisAlignment.end : MainAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: AppSize.s16.w,
                  //                             vertical: AppSize.s8.h
                  //                         ),
                  //                         decoration: BoxDecoration(
                  //                             color: chat?.direction == "SEND" ?  ColorManager.primaryColor
                  //                                 : ColorManager.chatCardColor,
                  //                             borderRadius: BorderRadius.circular(AppSize.s12.r)
                  //                         ),
                  //                         child: CustomTextNoOverFlow(text: chat?.message,
                  //                           fontSize: FontSize.s12,
                  //                           textColor: ColorManager.blckColor,),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 );
                  //               }),
                  //         );
                  //       }
                  //     } else {
                  //       return Padding(
                  //         padding: EdgeInsets.only(
                  //             top: MediaQuery.of(context).size.height * 0.2),
                  //         child: const LoadingIndicator(),
                  //       );
                  //     }
                  //   }, // builder should also handle the case when data is not fetched yet
                  // ),

                    FutureBuilder<List<Chats?>>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error Occurred'));
                          } else if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: AppSize.s96.h,
                                    ),
                                    Center(
                                        child: SvgPicture.asset("assets/images/empty_state.svg")
                                    ),
                                    SizedBox(
                                      height: AppSize.s49.h,
                                    ),

                                    const CustomText(text:
                                    "No Chats yet",
                                      textColor: ColorManager.blckColor,
                                      fontSize: FontSize.s16,),
                                    SizedBox(
                                      height: AppSize.s8.h,
                                    ),

                                  ],
                                ),
                              );
                            } else {
                              final offers = snapshot.data!;
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.55,
                                child: ListView.builder(
                                  controller: _scrollController,
                                    itemCount: offers.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final chat = offers[index];

                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: AppSize.s20.h
                                        ),
                                        child: Row(
                                          mainAxisAlignment: chat?.direction == "SEND" ?
                                          MainAxisAlignment.end : MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: AppSize.s16.w,
                                                vertical: AppSize.s8.h
                                              ),
                                              decoration: BoxDecoration(
                                                color: chat?.direction == "SEND" ?  ColorManager.primaryColor
                                                  : ColorManager.chatCardColor,
                                                borderRadius: BorderRadius.circular(AppSize.s12.r)
                                              ),
                                              child: CustomTextNoOverFlow(text: chat?.message,
                                              fontSize: FontSize.s12,
                                              textColor: ColorManager.blckColor,),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              );
                            }
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.2),
                              child: const LoadingIndicator(),
                            );
                          }
                        }),

                    // SizedBox(height: 100,)


                  ],
                ),
              ),
            ),
          ],
        ),
      )),

      bottomSheet: showBottomSheet
          ? BottomSheet(
          elevation: 0,
          onClosing: () {
            // Do something
          },
          builder: (BuildContext ctx) => Container(
              width: double.infinity,
              height: AppSize.s100.h,
              alignment: Alignment.center,
              padding:
              EdgeInsets.symmetric(horizontal: AppSize.s24.w,
                  vertical: AppSize.s15.h),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: AppSize.s18.h
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/icons/attachment.svg"),
                    SizedBox(width: AppSize.s5.w,),
                    Expanded(
                      child: TextFormField(
                        controller: chatController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: ColorManager.textFieldColor,
                        autofocus: true,

                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: ColorManager.textFieldColor,
                            fontSize: FontSize.s16
                        ),
                        onChanged: (value)async{
                        },
                        decoration: InputDecoration(
                          filled: false,
                          counterText: "",
                          fillColor: ColorManager.whiteColor,
                          contentPadding:  EdgeInsets.symmetric(
                            horizontal: AppSize.s20.w,
                            vertical: AppSize.s15.h
                          ),
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12.r),
                            borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                                width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12.r),
                            borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                                width: 1),
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize.s14.h,
                              horizontal: AppSize.s20.w
                            ),
                            child: InkWell(
                              onTap: ()async{
                              //  Send message
                                if(chatController.text.isNotEmpty){
                                  final bool isSent = await context.read<ChatsViewModel>().sendMessage(chatController.text, dashboardViewModel.tradeReference);

                                  print("Sent: $isSent");

                                  if(isSent){
                                    setState(() {
                                      chatController.text = "";
                                      ChatService().getChats(authProvider.userData.accessToken!, dashboardViewModel.tradeReference);
                                    });
                                  }
                                }
                              },
                              child: SizedBox(
                                // padding: EdgeInsets.all(10),
                                height: AppSize.s20.h,
                                  width: AppSize.s20.h,
                                  child: SvgPicture.asset(AppImages.sendIcon)),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(AppSize.s12.r),
                            borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                                width: 1),
                          ),
                          hintStyle: const TextStyle(
                              color: ColorManager.labelTextColor,
                              fontSize: FontSize.s16
                          ),
                          labelStyle: const TextStyle(
                              color: ColorManager.labelTextColor,
                              fontSize: FontSize.s16
                          ),
                          errorStyle: TextStyle(
                              color: ColorManager.redColor,
                              fontSize: FontSize.s16
                          ),
                        ),

                      ),
                    )
                  ],
                ),
              ))
      )
          : null,
    );
  }
}
