import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int timer = 5;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 38.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    width: 3.r,
                    color: Color(0xFF3E87FF),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    SvgPicture.asset(
                      "assets/images/Group 12.svg",
                    ),
                    Text(
                      '0',
                      style: TextStyle(fontSize: 26.sp),
                    ),
                  ],
                ),
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 80.r,
                  width: 80.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 3.r,
                      color: Color(0xFF3E87FF),
                    ),
                  ),
                  child: Center(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(-45 / 360),
                      child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)).,
                          builder: (context, snapshot) {
                            if (timer == 0) {
                              timer = 5;
                            } else {
                              timer -= 1;
                            }
                            return Text(
                              timer.toString(),
                              style: TextStyle(fontSize: 26.sp),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              Container(
                height: 38.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    width: 3.r,
                    color: Color(0xFF3E87FF),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(fontSize: 26.sp),
                    ),
                    SvgPicture.asset(
                      "assets/images/Group 13.svg",
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/images/Group 23.svg",
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/images/Group 17.svg",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
