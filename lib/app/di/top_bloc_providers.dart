import 'package:FilmFlu/app/constants/app_constants.dart';
import 'package:FilmFlu/presentation/features/details/bloc/media_detail_bloc.dart';
import 'package:FilmFlu/presentation/features/movie_list/bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TopBlocProviders extends StatelessWidget {
  final Widget child;
  final _getIt = GetIt.instance;

  TopBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _getIt<MediaListBloc>()
            ..add(
              const MediaListEvent.getMovieData(),
            )
            ..add(
              const MediaListEvent.getTVSeriesData(),
            ),
        ),
        BlocProvider(
          create: (context) => _getIt<MediaDetailBloc>()
            ..add(
              MediaDetailEvent.getMediaDetails(
                AppConstants.mediaType,
                AppConstants.mediaTypeId,
              ),
            )
            ..add(
              MediaDetailEvent.getCredits(
                AppConstants.mediaType,
                AppConstants.mediaTypeId,
              ),
            ),
        ),
      ],
      child: child,
    );
  }
}
