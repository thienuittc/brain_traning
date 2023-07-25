import 'package:audio_helper/audio_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/router.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home/home_view.dart';

void main() async {
 // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocatorInjector.setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await AudioHelper.initial(
        backgroundPrefix: 'assets/sounds/background/',
        backgroundMusicNames: [
          'b1.mp3',
          'b2.mp3',
          'b3.mp3',
          'b4.mp3',
          'b5.mp3',
          'b6.mp3',
        ],
      );
      AudioHelper.playMusic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...viewModelProviders],
      child: ScreenUtilInit(
        designSize: const Size(411, 822),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          title: 'Brain Training',
          onGenerateRoute: (settings) => MyRouter.generateRoute(settings),
          initialRoute: MyRouter.splash,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'ComicHelvetic',
          ),
        ),
      ),
    );
  }
}
