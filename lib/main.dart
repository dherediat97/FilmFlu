//Core Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FilmFlu/core/utils/utilScroll.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:go_router/go_router.dart';

import 'presentation/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(const FilmFlu());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);

class FilmFlu extends StatelessWidget {
  const FilmFlu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scrollBehavior:
                kIsWeb ? WebScrollBehavior() : const MaterialScrollBehavior(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.app_name,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
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
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(20),
                thumbColor: MaterialStatePropertyAll(primaryColor),
              ),
            ),
          );
        });
  }
}
