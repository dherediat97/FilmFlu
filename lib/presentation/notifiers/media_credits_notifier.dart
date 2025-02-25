import 'package:film_flu/data/models/media_type.dart';
import 'package:film_flu/domain/models/credits_media_entity.dart';
import 'package:film_flu/domain/repository/media_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_credits_notifier.g.dart';

@riverpod
class MediaCredits extends _$MediaCredits {
  @override
  Future<CreditsMediaEntity?> build(CreditsMediaState creditsMediaState) {
    return getCreditsByMediaItem(creditsMediaState);
  }

  Future<CreditsMediaEntity?> getCreditsByMediaItem(
    CreditsMediaState creditsMediaState,
  ) async {
    return ref.read(mediaRepositoryProvider).getCredits(
          MediaType.values.firstWhere(
            (element) => element.name == creditsMediaState.mediaType,
          ),
          creditsMediaState.id,
          creditsMediaState.languageName,
        );
  }
}

class CreditsMediaState {
  final String mediaType;
  final String id;
  final String languageName;
  final bool isCast;

  const CreditsMediaState({
    required this.mediaType,
    required this.id,
    required this.languageName,
    required this.isCast,
  });
}
