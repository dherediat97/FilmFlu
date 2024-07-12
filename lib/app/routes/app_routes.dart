import 'package:film_flu/presentation/features/home/home_controller.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_controller.dart';
import 'package:film_flu/presentation/features/person_details/person_details_controller.dart';
import 'package:film_flu/presentation/features/splash_screen/splash_controller.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashController(),
    routes: [
      GoRoute(
        path: 'main',
        builder: (context, state) => const HomeController(),
      ),
      GoRoute(
        path: 'mediaItemDetails/:mediaTypeId',
        builder: (context, state) {
          return MediaDetailController(
            mediaTypeId: state.pathParameters['mediaTypeId'].toString(),
          );
        },
      ),
      GoRoute(
        path: 'personDetails/:personId',
        builder: (context, state) => PersonDetailsController(
          personId: state.pathParameters['personId'].toString(),
        ),
      ),
    ],
  ),
];
