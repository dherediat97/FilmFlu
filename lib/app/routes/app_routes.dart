import 'package:film_flu/app/routes/app_path.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_controller.dart';
import 'package:film_flu/presentation/features/person_detail/person_detail_screen.dart';
import 'package:film_flu/presentation/features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => SplashPage(
      routePath: AppRoutePath.home,
    ),
    routes: [
      GoRoute(
        path: 'main',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: 'mediaItemDetails/:movieId',
        builder: (context, state) {
          return MediaDetailController(
            movieId: state.pathParameters['movieId'].toString(),
          );
        },
      ),
      GoRoute(
        path: 'personDetails/:personId',
        builder: (context, state) => PersonDetailsPage(
            personId: state.pathParameters['personId'].toString()),
      ),
    ],
  ),
];
