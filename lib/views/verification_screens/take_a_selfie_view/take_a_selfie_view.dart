import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/ednpoints.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../view_models/authentication_view_model/authentication_view_model.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/evs_pay_header_widget.dart';
import '../../../widgets/re_usable_widgets.dart';

class TakeASelfieView extends StatefulWidget {
  const TakeASelfieView({Key? key}) : super(key: key);

  @override
  State<TakeASelfieView> createState() => _TakeASelfieViewState();
}

class _TakeASelfieViewState extends State<TakeASelfieView> {
  final ImagePicker _picker = ImagePicker();

  File? file;
  XFile? xFile;

  String base64Image = "";


  handleChooseFromGallery(BuildContext context) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      xFile = pickedImage;
      file = File(pickedImage!.path);
    });

    final bytes =  file!.readAsBytesSync();
    base64Image = "data:image/png;base64,"+base64Encode(bytes);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s24.w,
            vertical: AppSize.s30.h),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const EvsPayHeaderWidget(),

            SizedBox(height: AppSize.s92.h,),

            Center(
              child: InkWell(
                  onTap: (){
                    handleChooseFromGallery(context);
                  },
                  child:  file == null ?
                  SvgPicture.asset(AppImages.selfieIcon) :
                  Container(
                    height: AppSize.s200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(AppSize.s20.r),
                        image: DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
                    ),
                  )
              ),
            ),

            SizedBox(height: AppSize.s70.h,),

            Center(
              child: Container(
                width: AppSize.s229.w,
                padding: EdgeInsets.symmetric(horizontal: AppSize.s50.w),
                child: const CustomTextWithLineHeight(text: AppStrings.takeAShot,
                  textColor: ColorManager.blackTextColor,
                  fontSize: FontSize.s24, fontWeight: FontWeightManager.bold,
                alignCenter: true,),
              ),
            ),

            SizedBox(height: AppSize.s10.h,),

            const CustomTextWithLineHeight(text: AppStrings.youWouldHaveToTake,
              textColor: ColorManager.blackTextColor,
              fontSize: FontSize.s14, fontWeight: FontWeightManager.medium,
              alignCenter: true,),

            SizedBox(height: AppSize.s100.h,),

            Consumer<AuthenticationProvider>(
                builder: (ctx, auth, child) {
                  WidgetsBinding.instance.
                  addPostFrameCallback((_) {
                    if (auth.resMessage != '') {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message: auth.resMessage,
                          backgroundColor: auth.success ?
                          ColorManager.deepGreenColor :
                          ColorManager.primaryColor,
                        ),
                      );

                      ///Clear the response message to avoid duplicate
                      auth.clear();
                    }
                  });
                return CustomElevatedButton(onTap: (){
                  //  perform upload of selfie
                  auth.verifyIdentity(idCard: base64Image, context: context, endPoint: Endpoints.uploadProfilePhoto);
                },
                    backgroundColor: ColorManager.primaryColor,
                    textColor: ColorManager.blackTextColor,
                    title: AppStrings.upload.toUpperCase());
              }
            )

          ],
        ),
      )),
    );
  }
}
