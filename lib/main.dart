import 'package:film_flu/app/di/di.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/presentation/top_blocs/cubit/language_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/utils/util_scroll.dart';
import 'package:film_flu/core/constants/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

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
    initialLocation: AppRoutePaths.main,
    routes: appRoutes,
  );

  @override
  Widget build(BuildContext context) {
    getIt<AppLocalDataSourceContract>().setLanguage('es');

    return BlocProvider(
      create: (context) => LanguageCubit(
          appLocalDataSourceContract: getIt<AppLocalDataSourceContract>()),
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
            ),
          );
        },
      ),
    );
  }
}
