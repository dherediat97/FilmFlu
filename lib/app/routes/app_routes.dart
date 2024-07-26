import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_controller.dart';
import 'package:film_flu/presentation/features/person_details/person_details_controller.dart';
import 'package:film_flu/presentation/features/settings/settings_screen.dart';
import 'package:film_flu/presentation/features/splash/splash_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:horusvision/presentation/features/horusvision.dart';

List<GoRoute> appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashController(),
    routes: [
      GoRoute(
        path: 'main',
        builder: (context, state) => const HomeScreen(),
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
      GoRoute(
        path: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: 'horusVision',
        builder: (context, state) => const HorusVision(),
      ),
    ],
  ),
];
