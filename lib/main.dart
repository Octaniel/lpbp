import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/app_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/my_theme.dart';
import 'app/translations/app_translations.dart';
import 'app/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main()  async {
      // TestWidgetsFlutterBinding.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();
      await GetStorage.init();
      // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
      OneSignal.shared.init(
//           "b856e4e5-e7c5-46cf-95e6-b67aea0fa4e7",
//           iOSSettings: {
//                 OSiOSSettings.autoPrompt: false,
//                 OSiOSSettings.inAppLaunchUrl: false
//           }
//       );
//       OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
//
// // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//       await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
//
//   OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) async {
//     Get.offNamed(Routes.MARCAPONTO);
//     Get.find<AppController>().tocarOuPausar();
//     await Future.delayed(Duration(minutes: 2), () async {
//       Get.find<AppController>().tocarOuPausar();
//       Get.offNamed(Routes.HOME);
//       // await Future.delayed(Duration(minutes: 3), () {
//       //   Get.offNamed(Routes.HOME);
//       // });
//     });
//   });
//
//   OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
//     Get.offNamed(Routes.MARCAPONTO);
//     Get.find<AppController>().tocarOuPausar();
//     await Future.delayed(Duration(minutes: 2), () async {
//       Get.find<AppController>().tocarOuPausar();
//       await Future.delayed(Duration(minutes: 3), () {
//         Get.offNamed(Routes.HOME);
//       });
//     });
//   });
//

      runApp(GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: GetPlatform.isMobile?Routes.HOME:Routes.LOGIN, //Rota inicial
      theme: appThemeData, //Tema personalizado app
      defaultTransition: Transition.fade, // Transição de telas padrão
      getPages: AppPages
          .pages, // Seu array de navegação contendo as rotas e suas pages
      locale: Locale('pt', 'BR'), // Língua padrão
      translationsKeys:
          AppTranslation.translations, // Suas chaves contendo as traduções<map>
    ));
}
