import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/domain/models/request_token_entity.dart';
import 'package:film_flu/domain/models/response_token_entity.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'media_list_provider.g.dart';

@riverpod
class MediaListPage extends _$MediaListPage {
  late SharedPreferences prefs;

  @override
  int build() {
    return 1;
  }

  reset() {
    return 1;
  }

  loadNewPage() {
    if (state > 3) {
      return;
    }
    state = state + 1;
  }

  Future<ResponseTokenEntity> createSession(String userToken) async {
    prefs = await SharedPreferences.getInstance();
    final requestToken = RequestTokenEntity.fromJson({
      'request_token': userToken,
      'approved': true,
    });
    final session = await ref
        .read(authRepositoryProvider)
        .newSession(requestToken);
    if (session.sessionId.isNotEmpty) {
      prefs.setString(AppConstants.userTokenKey, session.sessionId);
    }
    return session;
  }
}
