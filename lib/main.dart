import 'package:film_flu/app/l10n/localizations/app_localizations.dart';
import 'package:film_flu/app/routes/app_router.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:film_flu/core/utils/util_scroll.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: FilmFlu()));
}

class FilmFlu extends ConsumerWidget {
  const FilmFlu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final app = ref.watch(appProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior:
          kIsWeb ? WebScrollBehavior() : const MaterialScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: app.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      themeMode: app.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: app.theme.light(),
      darkTheme: app.theme.dark(),
    );
  }
}
