import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/di/di.dart';
import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/presentation/top_blocs/cubit/language_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/utils/util_scroll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  await initDi();
  runApp(FilmFlu());
}

class FilmFlu extends StatelessWidget {
  FilmFlu({super.key});

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutePaths.main,
    routes: appRoutes,
  );

  @override
  Widget build(BuildContext context) {
    return TopBlocProviders(
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            scrollBehavior:
                kIsWeb ? WebScrollBehavior() : const MaterialScrollBehavior(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _router,
            theme: ThemeData(
              fontFamily: 'YsabeauInfant',
              primaryColor: AppColors.primaryColor,
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
                primarySwatch: AppColors.primaryMaterialColor,
                backgroundColor: AppColors.backgroundColor,
                accentColor: AppColors.backgroundColor,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scrollbarTheme: const ScrollbarThemeData(
                radius: Radius.circular(20),
                thumbColor: WidgetStatePropertyAll(AppColors.primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
