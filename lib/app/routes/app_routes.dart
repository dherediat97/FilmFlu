import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/models/request_token_entity.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/media_list/widgets/movies_list.dart';
import 'package:film_flu/presentation/features/media_list/widgets/series_list.dart';
import 'package:film_flu/presentation/features/person_details/person_details_screen.dart';
import 'package:film_flu/presentation/features/person_list/trending_person_list.dart';
import 'package:film_flu/presentation/features/settings/settings_screen.dart';
import 'package:film_flu/presentation/features/common/custom_scaffold_page.dart';
import 'package:film_flu/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:horusvision/presentation/features/horusvision.dart';

part 'app_routes.g.dart';

@TypedGoRoute<StartScreenRoute>(
  path: AppPaths.startRoute,
  routes: [
    TypedGoRoute<HomeScreenRoute>(path: AppPaths.homeRoute),
    TypedGoRoute<AuthRoute>(path: AppPaths.authenticateRoute),
    TypedGoRoute<MovieScreenRoute>(path: AppPaths.movieRoute),
    TypedGoRoute<TVSeriesScreenRoute>(path: AppPaths.serieRoute),
    TypedGoRoute<TrendingPersonScreenRoute>(path: AppPaths.trendingPersonRoute),
    TypedGoRoute<MovieRoute>(path: '${AppPaths.movieRoute}/:id'),
    TypedGoRoute<SerieRoute>(path: '${AppPaths.serieRoute}/:id'),
    TypedGoRoute<PersonRoute>(path: '${AppPaths.personRoute}/:id'),
    TypedGoRoute<SettingsRoute>(path: AppPaths.settingsRoute),
    // TypedGoRoute<HorusVisionRoute>(path: AppPaths.horusVisionRoute),
  ],
)
@immutable
class StartScreenRoute extends GoRouteData {
  const StartScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplashScreen();
  }
}

@immutable
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(child: MoviesListWidget());
  }
}

@immutable
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final authJson = RequestTokenEntity(
      requestToken: state.uri.queryParameters['request_token'] ?? '',
      approved: state.uri.queryParameters['approved'] == 'true',
    );
    if (authJson.approved) {
      return ScaffoldPage(
        child: MoviesListWidget(userToken: authJson.requestToken),
      );
    }
    return ScaffoldPage(child: MoviesListWidget());
  }
}

@immutable
class MovieScreenRoute extends GoRouteData {
  const MovieScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(child: MoviesListWidget());
  }
}

@immutable
class TVSeriesScreenRoute extends GoRouteData {
  const TVSeriesScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(child: SeriesListWidget());
  }
}

class TrendingPersonScreenRoute extends GoRouteData {
  const TrendingPersonScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(child: TrendingPersonListWidget());
  }
}

class RedirectRoute extends GoRouteData {
  // There is no need to implement [build] when this [redirect] is unconditional.
  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return StartScreenRoute().location;
  }
}

@immutable
class MovieRoute extends GoRouteData {
  final int id;

  const MovieRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MediaItemScreenDetails(
      mediaId: id,
      languageCode: context.localizations.localeName,
      mediaType: MediaType.movie.name,
    );
  }
}

// @immutable
// class HorusVisionRoute extends GoRouteData {
//   const HorusVisionRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return HorusVision();
//   }
// }

@immutable
class SerieRoute extends GoRouteData {
  final int id;

  const SerieRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MediaItemScreenDetails(
      mediaId: id,
      languageCode: context.localizations.localeName,
      mediaType: MediaType.tv.name,
    );
  }
}

@immutable
class PersonRoute extends GoRouteData {
  final int id;

  const PersonRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(child: PersonItemScreenDetails(personId: id));
  }
}

@immutable
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsScreen();
  }
}
