import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_notifier.g.dart';

@riverpod
class Profile extends _$Profile {
  @override
  void build() {}

  Future<String> requestToken() async {
    final repository = ref.read(authRepositoryProvider);

    final requestNewTokenResponse = await repository.requestNewToken();

    return Future.value(
      '${AppUrls.authUrl}/authenticate/${requestNewTokenResponse.requestToken}?redirect_to=${Uri.base.origin}',
    );
  }

  Future<bool> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    repository.signOut();
    return true;
  }
}
