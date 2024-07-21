import 'package:film_flu/app/constants/app_fonts.dart';
import 'package:film_flu/app/constants/app_theme.dart';
import 'package:film_flu/app/di/di.dart';
import 'package:film_flu/app/di/top_bloc_providers.dart';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/presentation/top_blocs/app_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/utils/util_scroll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
  await initDi();
  //await horus_vision.initDi();
  runApp(FilmFlu());
}

class FilmFlu extends StatelessWidget {
  FilmFlu({super.key});

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutePaths.startRoute,
    routes: appRoutes,
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =
        createTextTheme(context, AppFonts.primaryFont, AppFonts.tertiaryFont);

    AppTheme theme = AppTheme(textTheme);

    return BlocProvider(
      create: (context) => AppBloc(
          appLocalDataSourceContract: getIt<AppLocalDataSourceContract>()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return TopBlocProviders(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              scrollBehavior:
                  kIsWeb ? WebScrollBehavior() : const MaterialScrollBehavior(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: state.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: _router,
              themeMode: state.themeMode,
              theme: theme.light(),
              darkTheme: theme.dark(),
              highContrastDarkTheme: theme.darkHighContrast(),
              highContrastTheme: theme.lightHighContrast(),
            ),
          );
        },
      ),
    );
  }
}
