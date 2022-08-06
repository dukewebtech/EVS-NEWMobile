import 'dart:io';

import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/user_profile_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/app_texts/label_text.dart';
import 'package:evs_pay_mobile/widgets/app_texts/loading_widget.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/edit_profile_item.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameEditingController = TextEditingController();

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
  void initState() {
    nameEditingController.text = "Areous Ahmad";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserProfileViewModel userProfileViewModel = context.watch<UserProfileViewModel>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.profileEdit,
          isCenterAlign: true,
          leadingTap: (){
            Navigator.pop(context);
          }),

      body: SafeArea(child: SingleChildScrollView(
        child: _content(userProfileViewModel),
      )),
    );
  }

  _content(UserProfileViewModel userProfileViewModel) {
    if(userProfileViewModel.loading){
      return const Center(child: AppLoading());
    }

    if(userProfileViewModel.userError != null){
      return ErrorWidget(userProfileViewModel.userError!.message);
    }

    return Column(
      children: [
        SizedBox(height: AppSize.s76.h,),
        Center(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  handleChooseFromGallery(context);
                },
                child: file == null ? Container(
                  height: AppSize.s114.h,
                  width: AppSize.s114.h,
                  decoration: BoxDecoration(
                      color: ColorManager.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.s100.r),
                      image: const DecorationImage(image:  AssetImage(AppImages.dummyGuy), fit: BoxFit.cover)
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: AppSize.s40.h,
                        left: AppSize.s40.w,
                        child: SvgPicture.asset(AppImages.camera),
                      ),
                    ],
                  ),
                ) : Container(
                  height: AppSize.s114.h,
                  width: AppSize.s114.h,
                  decoration: BoxDecoration(
                      color: ColorManager.blackTextColor,
                      borderRadius: BorderRadius.circular(AppSize.s100.r),
                      image:  DecorationImage(image:  FileImage(file!), fit: BoxFit.cover)
                  ),
                ),
              ),
              SizedBox(height: AppSize.s10.h,),
              const SizedBox(width: AppSize.s212,
                child: CustomTextWithLineHeight(
                    alignCenter: true,
                    text: AppStrings.tapOnTheImageToChangeProfilePicture),)
            ],
          ),
        ),

        SizedBox(height: AppSize.s30.h,),

        Padding(padding: EdgeInsets.symmetric(
            horizontal: AppSize.s26.w
        ),
          child: Column(
            children: [
              const LabelText(text: AppStrings.name),
              SizedBox(height: AppSize.s10.h,),
              CustomTextField(controller: userProfileViewModel.nameEditingController, contentPadding: AppSize.s20,),

              SizedBox(height: AppSize.s27.h,),

              const LabelText(text: AppStrings.email),
              SizedBox(height: AppSize.s10.h,),
              EditProfileItem(iconName: AppImages.good,
                title: userProfileViewModel.userProfile.data!.email,
                textColor: ColorManager.greenColor,
                borderColor: ColorManager.greenColor,),

              SizedBox(height: AppSize.s27.h,),

              const LabelText(text: AppStrings.userName),
              SizedBox(height: AppSize.s10.h,),
              EditProfileItem(iconName: AppImages.good,
                  title: userProfileViewModel.userProfile.data!.email,
                  textColor: ColorManager.greenColor,
                  borderColor: ColorManager.greenColor),

              SizedBox(height: AppSize.s27.h,),

              const LabelText(text: AppStrings.phone),
              SizedBox(height: AppSize.s10.h,),
              EditProfileItem(
                  iconName: AppImages.close,
                  title: userProfileViewModel.userProfile.data!.phone,
                  textColor: ColorManager.errorColor,
                  borderColor: ColorManager.errorColor),

              SizedBox(height: AppSize.s37.h,),

              CustomElevatedButton(onTap: (){}, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.saveChanges),

              SizedBox(height: AppSize.s37.h,),


            ],
          ),
        )
      ],
    );
  }
}
