import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/evs_pay_header_widget.dart';
import '../../../widgets/re_usable_widgets.dart';

class UploadIdView extends StatefulWidget {
  const UploadIdView({Key? key}) : super(key: key);

  @override
  State<UploadIdView> createState() => _UploadIdViewState();
}

class _UploadIdViewState extends State<UploadIdView> {
  final ImagePicker _picker = ImagePicker();

  File? file;
  XFile? xFile;


  handleChooseFromGallery(BuildContext context) async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      xFile = file;
      this.file = File(file!.path);
    });

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
                  SvgPicture.asset(AppImages.idCardIcon) :
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

            const Center(
              child: CustomTextWithLineHeight(text: AppStrings.uploadYourID,
                textColor: ColorManager.blackTextColor,
                fontSize: FontSize.s24, fontWeight: FontWeightManager.bold,),
            ),

            SizedBox(height: AppSize.s10.h,),

            const CustomTextWithLineHeight(text: AppStrings.uploadEitherYourPassport,
              textColor: ColorManager.blackTextColor,
              fontSize: FontSize.s14, fontWeight: FontWeightManager.medium,
              alignCenter: true,),

            SizedBox(height: AppSize.s100.h,),

            CustomElevatedButton(onTap: (){
            //  perform upload of ID here
            },
                backgroundColor: ColorManager.primaryColor,
                textColor: ColorManager.blackTextColor,
                title: AppStrings.upload.toUpperCase())

          ],
        ),
      )),
    );
  }
}
