import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/constants/app_constants.dart';

import 'app/routes/app_pages.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String defaultHome = AppPages.INITIAL;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  final box = GetStorage();
  final token = box.read('token');
  if (token != null) {
    defaultHome = Routes.HOME;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: blue,
            ),
          ),
          initialRoute: defaultHome,
          getPages: AppPages.routes,
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
