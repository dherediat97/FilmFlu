import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/home/home_screen.dart';
import 'package:film_flu/presentation/features/media_details/media_detail_screen.dart';
import 'package:film_flu/presentation/features/person_details/person_details_screen.dart';
import 'package:film_flu/presentation/features/settings/settings_screen.dart';
import 'package:film_flu/presentation/features/common/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: [
    TypedGoRoute<MovieRoute>(path: 'movie/:id'),
    TypedGoRoute<SerieRoute>(path: 'tv/:id'),
    TypedGoRoute<PersonRoute>(path: 'person/:id'),
    TypedGoRoute<SettingsRoute>(path: 'settings'),
  ],
)
@immutable
class HomeScreenRoute extends GoRouteData {
  const HomeScreenRoute({this.mediaTypeSelected = MediaType.movie});

  final MediaType mediaTypeSelected;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScaffoldPage(
      child: HomeScreen(mediaTypeSelected: mediaTypeSelected),
    );
  }
}

class RedirectRoute extends GoRouteData {
  // There is no need to implement [build] when this [redirect] is unconditional.
  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return HomeScreenRoute(mediaTypeSelected: MediaType.movie).location;
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
