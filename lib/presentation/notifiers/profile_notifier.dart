import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_notifier.g.dart';

@riverpod
class Profile extends _$Profile {
  @override
  void build() async {
    final repository = ref.read(authRepositoryProvider);

    final requestNewTokenResponse = await repository.requestNewToken();
    // launchUrl(
    //   Uri.parse(
    //     '${AppUrls.authUrl}/authenticate/${requestNewTokenResponse.requestToken}?redirect_to=${Uri.base.origin}',
    //   ),
    // );
  }
}
