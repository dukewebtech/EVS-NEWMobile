
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/value_manager.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s4.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(AppSize.s5.r),
        width: AppSize.s100.w,
        height: AppSize.s100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s4.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSize.s30.h,),
            SizedBox(
              height: AppSize.s50.h,
              width: AppSize.s50.w,
              child: const CupertinoActivityIndicator(),
            ),
            SizedBox(height: AppSize.s10.h,),


          ],
        ),
      ),
    );

  }
}