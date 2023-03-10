import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../resources/ednpoints.dart';
import '../../../resources/value_manager.dart';
import '../../../view_models/authentication_view_model/authentication_view_model.dart';
import '../../../widgets/evs_pay_header_widget.dart';

class ProofOfAddressView extends StatefulWidget {
  const ProofOfAddressView({Key? key}) : super(key: key);

  @override
  State<ProofOfAddressView> createState() => _ProofOfAddressViewState();
}

class _ProofOfAddressViewState extends State<ProofOfAddressView> {
  final ImagePicker _picker = ImagePicker();

  File? file;
  XFile? xFile;

  String base64Image = "";

  handleChooseFromGallery(BuildContext context) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      xFile = pickedImage;
      file = File(pickedImage!.path);
    });

    final bytes = file!.readAsBytesSync();
    base64Image = "data:image/png;base64," + base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s24.w, vertical: AppSize.s30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EvsPayHeaderWidget(),
            SizedBox(
              height: AppSize.s92.h,
            ),
            InkWell(
                onTap: () {
                  handleChooseFromGallery(context);
                },
                child: file == null
                    ? Center(
                        child: DottedBorder(
                          strokeWidth: 1,
                          dashPattern: const [0, 5, 4],
                          // strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 180,
                              width: 250,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Tap to upload address from your\n gallary',
                                        style: TextStyle(
                                          fontFamily: 'lexend',
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      Icon(
                                        Icons.photo_album_outlined,
                                        size: 40,
                                      )
                                      // SvgPicture.asset(
                                      //   AppImages.proofOfAddressIcon,
                                      //   height: 40,
                                      //   width: 40,
                                      // )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          height: 180,
                          width: 250,
                          decoration: BoxDecoration(
                              color: ColorManager.primaryColor,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                              image: DecorationImage(
                                  image: FileImage(file!), fit: BoxFit.cover)),
                        ),
                      )),
            // Center(
            //   child: InkWell(
            //       onTap: () {
            //         handleChooseFromGallery(context);
            //       },
            //       child: file == null
            //           ? SvgPicture.asset(AppImages.proofOfAddressIcon)
            //           : Container(
            //               height: AppSize.s200.h,
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                   color: ColorManager.primaryColor,
            //                   borderRadius:
            //                       BorderRadius.circular(AppSize.s20.r),
            //                   image: DecorationImage(
            //                       image: FileImage(file!), fit: BoxFit.cover)),
            //             )),
            // ),
            SizedBox(
              height: AppSize.s70.h,
            ),
            const Center(
              child: CustomTextWithLineHeight(
                text: AppStrings.proofOfAddress,
                textColor: ColorManager.blackTextColor,
                fontSize: FontSize.s24,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            SizedBox(
              height: AppSize.s10.h,
            ),
            const CustomTextWithLineHeight(
              text: AppStrings.uploadEitherCable,
              textColor: ColorManager.blackTextColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.medium,
              alignCenter: true,
            ),
            SizedBox(
              height: AppSize.s100.h,
            ),
            Consumer<AuthenticationProvider>(builder: (ctx, auth, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (auth.resMessage != '') {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.info(
                      message: auth.resMessage,
                      backgroundColor: auth.success
                          ? ColorManager.deepGreenColor
                          : ColorManager.primaryColor,
                    ),
                  );

                  ///Clear the response message to avoid duplicate
                  auth.clear();
                }
              });
              return CustomElevatedButton(
                  onTap: () {
                    //  perform upload of Address here
                    if (base64Image.isEmpty) {
                    } else {
                      auth.verifyIdentity(
                          idCard: base64Image,
                          context: context,
                          endPoint: Endpoints.verifyHome);
                    }
                  },
                  backgroundColor: ColorManager.primaryColor,
                  textColor: ColorManager.blackTextColor,
                  title: AppStrings.upload.toUpperCase());
            })
          ],
        ),
      )),
    );
  }
}
