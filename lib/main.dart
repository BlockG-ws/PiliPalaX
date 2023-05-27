import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:pilipala/http/init.dart';
import 'package:pilipala/router/app_pages.dart';
import 'package:pilipala/pages/main/view.dart';
import 'package:pilipala/utils/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GStrorage.init();
  await Request.setCookie();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: ((lightDynamic, darkDynamic) {
        // 图片缓存
        // PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 20;
        return GetMaterialApp(
          title: 'PiLiPaLa',
          theme: ThemeData(
            colorScheme: lightDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.light,
                ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.dark,
                ),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale("zh", "CN"),
          supportedLocales: const [Locale("zh", "CN"), Locale("en", "US")],
          fallbackLocale: const Locale("zh", "CN"),
          getPages: Routes.getPages,
          home: const MainApp(),
          builder: FlutterSmartDialog.init(),
        );
      }),
    );
  }
}