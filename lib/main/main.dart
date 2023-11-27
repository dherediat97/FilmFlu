//Core Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//My Packages
import 'package:FilmFlu/core/utils/utilScroll.dart';
import 'package:FilmFlu/core/constants/theme/colors.dart';
import 'package:FilmFlu/main/app_module.dart';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: true,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  //Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(ModularApp(module: AppModule(), child: const FilmFlu()));
}

class FilmFlu extends StatefulWidget {
  const FilmFlu({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _FilmFluState? state = context.findAncestorStateOfType<_FilmFluState>();
    state?.setLocale(newLocale);
  }

  static String getLocale() {
    return _FilmFluState().getLocaleState();
  }

  @override
  State<FilmFlu> createState() => _FilmFluState();
}

class _FilmFluState extends State<FilmFlu> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocaleState() {
    getLocale().then((locale) => {setLocale(locale)});
  }

  @override
  void didChangeDependencies() {
    getLocaleState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scrollBehavior:
                kIsWeb ? WebScrollBehavior() : MaterialScrollBehavior(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.app_name,
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
                radius: Radius.circular(20),
                thumbColor: MaterialStatePropertyAll(primaryColor),
              ),
            ),
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          );
        });
  }
}
