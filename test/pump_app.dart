import 'package:film_flu/data/repositories/local/app_local_data_source_contract.dart';
import 'package:film_flu/domain/repository_contracts/media_list_repository_contract.dart';
import 'package:film_flu/domain/repository_contracts/media_repository_contract.dart';
import 'package:film_flu/domain/repository_contracts/person_repository_contract.dart';
import 'package:film_flu/presentation/features/bottom_app_bar/bloc/home_bloc.dart';
import 'package:film_flu/presentation/features/media_details/bloc/media_detail_bloc.dart';
import 'package:film_flu/presentation/features/media_list/bloc/media_list_bloc.dart';
import 'package:film_flu/presentation/features/person_details/bloc/person_details_bloc.dart';
import 'package:film_flu/presentation/top_blocs/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> pumpApp({
  required WidgetTester tester,
  required Widget child,
}) async {
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            appLocalDataSourceContract: getIt<AppLocalDataSourceContract>(),
          ),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            repositoryContract: getIt<MediaListRepositoryContract>(),
          ),
        ),
        BlocProvider(
          create: (context) => MediaListBloc(
            mediaListRepository: getIt<MediaListRepositoryContract>(),
          ),
        ),
        BlocProvider(
          create: (context) => MediaDetailBloc(
            mediaRepository: getIt<MediaRepositoryContract>(),
          ),
        ),
        BlocProvider(
          create: (context) => PersonDetailsBloc(
            repositoryContract: getIt<PersonRepositoryContract>(),
          ),
        )
      ],
      child: MaterialApp(
        home: child,
      ),
    ),
  );
}
