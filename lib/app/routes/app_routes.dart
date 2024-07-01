import 'package:FilmFlu/presentation/features/home/home_screen.dart';
import 'package:FilmFlu/presentation/features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashPage(),
    routes: const [],
  ),
  GoRoute(
    path: '/main',
    builder: (context, state) => const HomeScreen(),
    routes: const [],
  ),
];
