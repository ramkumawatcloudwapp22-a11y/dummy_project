import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/l10n/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/nav_provider.dart';
import 'providers/splash_provider.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const TechYodhaApp());
}

class TechYodhaApp extends StatelessWidget {
  const TechYodhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return MaterialApp(
            title: 'Tech Yodha',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
