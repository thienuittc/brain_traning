library home_view;

import 'package:brain_training/core/view_models/screen/interfaces/iquestion_viewmodel.dart';
import 'package:brain_training/views/base_screen/base_screen.dart';
import 'package:brain_training/views/home/widgets/header.dart';
import 'package:brain_training/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'home_view_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({Key key}) : super(key: key);
  @override
  Widget build() {
    return _HomeScreen();
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  IQuestionViewModel _iQuestionViewModel;
  @override
  void initState() {
    _iQuestionViewModel = context.read<IQuestionViewModel>();
    _iQuestionViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: const Header()),
          Expanded(
            flex: 2,
            child: Consumer<IQuestionViewModel>(builder: (context, vm, state) {
              return vm.playing
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vm.curnentCalculation,
                          style: TextStyle(fontSize: 70.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _iQuestionViewModel.checkAnswer(false);
                                  },
                                  child: Card(
                                    color: Colors.redAccent,
                                    child: SizedBox(
                                      height: 200.h,
                                      child: Center(
                                        child: Text(
                                          'Sai',
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _iQuestionViewModel.checkAnswer(true);
                                  },
                                  child: Card(
                                    color: Colors.greenAccent,
                                    child: SizedBox(
                                      height: 200.h,
                                      child: Center(
                                        child: Text(
                                          'Đúng',
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPressed: () {
                              vm.setPlaying = true;
                            },
                            height: 70.h,
                            text: "Chơi tiếp",
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: CustomButton(
                              onPressed: () {
                                vm.setMusic = !vm.musicOn;
                              },
                              height: 70.h,
                              text: !vm.musicOn ? "Mở nhạc" : "Tắt nhạc",
                              color: Colors.blueAccent,
                            ),
                          )
                        ],
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
