import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/person_detail/bloc/person_detail_bloc.dart';
import 'package:film_flu/presentation/top_blocs/language_cubit.dart';
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
        BlocProvider(create: (context) => _getIt<LanguageCubit>()),
        BlocProvider(
            create: (context) => _getIt<MediaListBloc>()
              ..add(
                const MediaListEvent.getMediaData(),
              )),
        BlocProvider(
          create: (context) => _getIt<MediaDetailBloc>()
            ..add(
              MediaDetailEvent.getMediaDetails(
                AppConstants.mediaType,
                AppConstants.mediaTypeId.toString(),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => _getIt<PersonDetailBloc>()
            ..add(
              PersonDetailEvent.getPersonData(
                AppConstants.personId,
              ),
            ),
        ),
      ],
      child: child,
    );
  }
}
