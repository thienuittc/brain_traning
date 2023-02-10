import 'package:brain_training/core/view_models/screen/interfaces/iquestion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int timer = 5;
  CountdownController countdownController = CountdownController();
  IQuestionViewModel viewModel;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      viewModel = context.read<IQuestionViewModel>();
      viewModel.setCountdownController(countdownController);
    });
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
                    Consumer<IQuestionViewModel>(
                      builder: (context, vm, state) {
                        return Text(
                          vm.curnentScore.toString(),
                          style: TextStyle(fontSize: 26.sp),
                        );
                      },
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
                      child: Countdown(
                        controller: countdownController,
                        seconds: 3,
                        build: (BuildContext context, double time) =>
                            Text(time.toInt().toString()),
                        interval: Duration(seconds: 1),
                        onFinished: () {
                          viewModel.timeOut();
                        },
                      ),
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
                    Consumer<IQuestionViewModel>(
                      builder: (context, vm, state) {
                        return Text(
                          vm.level.toString(),
                          style: TextStyle(fontSize: 26.sp),
                        );
                      },
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
