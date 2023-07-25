import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './custom_button.dart';

class GemDialog extends StatelessWidget {
  const GemDialog({Key key, this.onBack}) : super(key: key);
  final Function onBack;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 23.h),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 35.w, right: 35.w),
              height: 240.h,
              width: 335.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  width: 8.r,
                  color: Color(0xFF3E87FF),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cố lên một xíu nữa thôi (>.<)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  CustomButton(
                    fillBackGround: false,
                    text: "OK",
                    onPressed: () {
                      onBack();
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 46.h,
            width: 182.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                width: 3.r,
                color: Color(0xFF3E87FF),
              ),
            ),
            child: Text(
              "Thua rồi TT",
              style: TextStyle(
                fontSize: 24.sp,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
