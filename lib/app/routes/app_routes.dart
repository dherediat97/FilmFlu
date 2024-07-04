import 'package:FilmFlu/domain/models/details_movie_arguments.dart';
import 'package:FilmFlu/presentation/features/media_details/media_detail_screen.dart';
import 'package:FilmFlu/presentation/features/home/home_screen.dart';
import 'package:FilmFlu/presentation/features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashPage(),
    routes: [
      GoRoute(
        path: 'main',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: 'mediaItemDetails',
        builder: (context, state) {
          final arguments = state.extra as Map<String, dynamic>;
          return MediaItemScreenDetails(
            movieArguments: DetailsMovieArguments(
              movieId: arguments['mediaId'].toString(),
              mediaType: arguments['mediaType'],
            ),
          );
        },
      ),
    ],
  ),
  // GoRoute(
  //   path: '/personDetails/:personId',
  //   builder: (context, state) =>
  //       const PersonDetailsPage(actorId: state.personId),
  // ),
];
