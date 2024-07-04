import 'package:FilmFlu/app/di/di.dart';
import 'package:FilmFlu/app/l10n/localizations/app_localizations.dart';
import 'package:FilmFlu/app/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:FilmFlu/core/utils/util_scroll.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  //Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  await initDi();
  runApp(FilmFlu());
}

class FilmFlu extends StatelessWidget {
  FilmFlu({super.key});

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    routes: appRoutes,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scrollBehavior:
            kIsWeb ? WebScrollBehavior() : const MaterialScrollBehavior(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
        theme: ThemeData(
          fontFamily: 'YsabeauInfant',
          primaryColor: primaryColor,
          useMaterial3: true,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
              fontFamily: 'YsabeauInfant',
            ),
          ),
          splashFactory: NoSplash.splashFactory,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: primaryMaterialColor,
            backgroundColor: backgroundColor,
            accentColor: backgroundColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scrollbarTheme: const ScrollbarThemeData(
            radius: Radius.circular(20),
            thumbColor: WidgetStatePropertyAll(primaryColor),
          ),
        ));
  }
}
