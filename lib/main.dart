import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrsstranslinkcompany/pages/404/error.dart';
import 'package:vrsstranslinkcompany/pages/authentication/authentication.dart';
import 'package:vrsstranslinkcompany/pages/authentication/binding/authbinding.dart';
import 'Companylayout.dart';
import 'Prelogin.dart';
import 'constants/style.dart';
import 'controllers/AuthService.dart';
import 'controllers/navigation_controller.dart';
import 'helpers/GlobalContext.dart';
import 'routing/routes.dart';
import 'package:vrsstranslinkcompany/controllers/menu_controller.dart' as menu_controller;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (context,child ) =>GetMaterialApp(
        navigatorKey: GlobalContext.navigatorKey,
      initialRoute: prelogin,
      unknownRoute: GetPage(name: '/not-found', page: () => const PageNotFound(), transition: Transition.fadeIn),
      getPages: [
        GetPage(
            name: authenticationPageRoute,
            page: () =>  AuthenticationPage(),
            binding: AuthBinding(),
        ),
        GetPage(
          name: CompanyrootRoute,
          page: () => SiteLayout(),
          // middlewares: [PremiumGuard()],
        ),
        GetPage(
            name: prelogin, page: (){
            return const PreLogin();
        })
      ],
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    )
    );
  }
}
