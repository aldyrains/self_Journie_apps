import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/global/bindings/app_binding.dart';
import 'app/global/const/colors.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
   Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          // navigatorKey: MyApp.navigatorKey,
          theme: ThemeData(
              // useMaterial3: true,
              backgroundColor: Colors.white,
              primaryColor: ColorsApp.primary,
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  elevation: 0,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  foregroundColor: Colors.black87),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r)))),
              checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.all(ColorsApp.primary)),
              colorScheme: const ColorScheme.light(primary: ColorsApp.primary),
              inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintStyle: Get.textTheme.labelMedium!.copyWith(
                      color: Colors.grey.shade600, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.0))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.0))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: ColorsApp.secondary.withOpacity(0.0))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Colors.red.withOpacity(0.2)))),
              fontFamily: GoogleFonts.montserrat().fontFamily,
              textTheme: TextTheme(
                displayLarge:
                    TextStyle(fontSize: 96.sp, fontWeight: FontWeight.w500),
                displayMedium: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.w500,
                ),
                displaySmall:
                    TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w500),
                headlineLarge:
                    TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w500),
                headlineMedium:
                    TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
                headlineSmall:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                titleLarge:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                titleMedium:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                titleSmall:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                bodyLarge:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                bodyMedium:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                bodySmall:
                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                labelLarge:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                labelMedium:
                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                labelSmall:
                    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
              )),
          title: "Application",
          initialBinding: AppBinding(),
          builder: (context, widget) {
            ///Setting font does not change with system font size
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: widget ??
                  const Center(
                    child: Text("No screen provided"),
                  ),
            );
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}

