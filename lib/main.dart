import 'package:flutter/material.dart';
import 'package:our_pass/core/services/app_setup.dart';
import 'package:our_pass/features/splash/splash_screen.dart';
import 'package:our_pass/providers.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSetups.runSetups().whenComplete(
    () => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Our Pass Auth',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
