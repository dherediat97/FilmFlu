import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/models/auth_entity.dart';
import 'package:film_flu/domain/models/profile_entity.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_notifier.g.dart';

@riverpod
class Profile extends _$Profile {
  AuthRepository get repository => ref.read(authRepositoryProvider);

  @override
  Future<ProfileEntity> build() {
    return getProfile('20111553');
  }

  Future<String> requestToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppConstants.userTokenKey) != null) {
      return '';
    }

    final requestNewTokenResponse = await repository.requestNewToken();

    return Future.value(
      '${AppUrls.authUrl}/authenticate/${requestNewTokenResponse.requestToken}?redirect_to=${Uri.base.origin}/${AppPaths.authenticateRoute}',
    );
  }

  Future<bool> signOut(AuthEntity authEntity) async {
    return repository.signOut(authEntity);
  }

  Future<ProfileEntity> getProfile(String accountId) async {
    final profileResponse = await repository.getProfile(accountId);
    return profileResponse;
  }
}
