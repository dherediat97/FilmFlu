import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/domain/models/search_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultView extends ListTile {
  const SearchResultView({
    super.key,
    required this.searchResult,
    required this.controller,
  });

  final SearchController controller;
  final SearchResultEntity searchResult;

  @override
  Widget build(BuildContext context) {
    switch (searchResult.mediaType) {
      case MediaType.movie:
        return _buildMovieTile(context);
      case MediaType.tv:
        return _buildTvSerieTile(context);
      case MediaType.person:
        return _buildPersonTile(context);
    }
  }

  _buildPersonTile(BuildContext context) {
    return ListTile(
      onTap: () {
        controller.closeView(null);
        controller.clear();
        context.push('/main/${searchResult.mediaType.name}/${searchResult.id}');
      },
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      leading: Image.network(
        searchResult.profilePath != null
            ? AppUrls.personImgBaseUrl + searchResult.profilePath!
            : AppAssets.actorImageIcon,
        height: 400,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
      ),
      title: Text(searchResult.name ?? ''),
      subtitle: Text(searchResult.knownForDepartment ?? ''),
    );
  }

  _buildTvSerieTile(BuildContext context) {
    return ListTile(
      onTap: () {
        controller.closeView(null);
        controller.clear();
        context.push('/main/${searchResult.mediaType.name}/${searchResult.id}');
      },
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      leading: Image.network(
        searchResult.posterPath != null
            ? AppUrls.movieLandscapeBaseUrl + searchResult.posterPath!
            : AppAssets.actorImageIcon,
        height: 400,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
      ),
      title: Text(searchResult.name ?? ''),
      subtitle: Text(searchResult.firstAirDate ?? ''),
    );
  }

  _buildMovieTile(BuildContext context) {
    return ListTile(
      onTap: () {
        controller.closeView(null);
        controller.clear();
        context.push('/main/${searchResult.mediaType.name}/${searchResult.id}');
      },
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      leading: Image.network(
        searchResult.posterPath != null
            ? AppUrls.movieLandscapeBaseUrl + searchResult.posterPath!
            : AppAssets.actorImageIcon,
        height: 400,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
      ),
      title: Text(searchResult.title ?? ''),
      subtitle: Text(searchResult.releaseDate ?? ''),
    );
  }
}
