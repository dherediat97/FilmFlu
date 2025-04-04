import 'dart:ui';
import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_router.dart';
import 'package:film_flu/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/utils/util_scroll.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart' show usePathUrlStrategy;

late FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) usePathUrlStrategy();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(const ProviderScope(child: FilmFlu()));
}

class FilmFlu extends ConsumerWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      scrollBehavior:
          kIsWeb
              ? WebScrollBehavior()
              : const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: state.appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: state.appTheme.light(),
      darkTheme: state.appTheme.dark(),
    );
  }
}
