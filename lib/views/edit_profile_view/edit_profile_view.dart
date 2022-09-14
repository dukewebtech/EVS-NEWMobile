import 'dart:convert';
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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/ednpoints.dart';
import '../../view_models/authentication_view_model/authentication_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameEditingController = TextEditingController();

  String base64Image = "";

  final ImagePicker _picker = ImagePicker();

  File? file;
  XFile? xFile;


  handleChooseFromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      xFile = pickedFile;
      file = File(pickedFile!.path);

    });

    final bytes =  file!.readAsBytesSync();
    base64Image = "data:image/png;base64,"+base64Encode(bytes);

  }

  // handleChooseFromGallery(BuildContext context) async {
  //   final XFile? file = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   setState(() {
  //     xFile = file;
  //     this.file = File(file!.path);
  //   });
  //
  // }

  @override
  void initState() {
    nameEditingController.text = "Areous Ahmad";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserProfileViewModel userProfileViewModel = context.watch<UserProfileViewModel>();
    final authProvider = context.watch<AuthenticationProvider>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.profileEdit,
          isCenterAlign: true,
          leadingTap: (){
            Navigator.pop(context);
          }),

      body: SafeArea(child: SingleChildScrollView(
        child: _content(userProfileViewModel, authProvider),
      )),
    );
  }

  _content(UserProfileViewModel userProfileViewModel, AuthenticationProvider authProvider) {
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
              EditProfileItem(
                  iconName: authProvider.userData.user!.emailVerified!? AppImages.good : AppImages.close,
                title: userProfileViewModel.userProfile.data!.email,
                textColor: ColorManager.greenColor,
                borderColor: authProvider.userData.user!.emailVerified!? ColorManager.greenColor :
                ColorManager.redColor),

              SizedBox(height: AppSize.s27.h,),

              const LabelText(text: AppStrings.userName),
              SizedBox(height: AppSize.s10.h,),
              EditProfileItem(iconName: AppImages.good,
                  title: userProfileViewModel.userProfile.data!.username,
                  textColor: ColorManager.greenColor,
                  borderColor: ColorManager.greenColor),

              SizedBox(height: AppSize.s27.h,),

              const LabelText(text: AppStrings.phone),
              SizedBox(height: AppSize.s10.h,),
              EditProfileItem(
                  iconName: authProvider.userData.user!.phoneVerified!? AppImages.good : AppImages.close,
                  title: userProfileViewModel.userProfile.data!.phone,
                  textColor: authProvider.userData.user!.phoneVerified!? ColorManager.greenColor :
                  ColorManager.redColor,
                  borderColor: authProvider.userData.user!.phoneVerified!? ColorManager.greenColor :
                  ColorManager.redColor),

              SizedBox(height: AppSize.s37.h,),

              Consumer<AuthenticationProvider>(
                  builder: (ctx, auth, child) {
                  return CustomElevatedButton(onTap: ()async{
                    //  upload profile picture if it is not empty
                    if(base64Image.isNotEmpty){
                      print("BAse64Image: $base64Image");
                      final updated = await auth.updateProfilePhoto(idCard: base64Image, context: context, endPoint: Endpoints.uploadProfilePhoto);

                      if(updated){
                        setState(() {
                          base64Image = "";
                        });
                      }
                    }
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

                  },
                      backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.saveChanges);
                }
              ),


              SizedBox(height: AppSize.s37.h,),


            ],
          ),
        )
      ],
    );
  }
}
