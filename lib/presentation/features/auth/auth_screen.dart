import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/presentation/notifiers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Profile get profileNotifier => ref.watch(profileProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            profile.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => const Icon(Icons.error),
              data: (profile) {
                return ListTile(
                  leading: Image.network(
                    '${AppUrls.profileImgBaseUrl}${profile.username}',
                  ),
                  title: Text(profile.username, style: TextStyle(fontSize: 16)),
                );
              },
            ),
            const Divider(),
            if (profile.hasValue) ...[
              ListTile(
                leading: const Icon(Icons.logout),
                onTap: () => _signOut(),
                title: Text('Cerrar sesión'),
              ),
            ],
            if (!profile.hasValue) ...[
              ListTile(
                leading: const Icon(Icons.account_circle),
                onTap: () => _signIn(),
                title: Text('Iniciar sesión con TMDB'),
              ),
            ],
            ListTile(
              leading: const Icon(Icons.settings),
              onTap: () => _openSettingsScren(),
              title: Text(context.localizations.settings),
            ),
          ],
        ),
      ),
    );
  }

  _signIn() async {
    bool result = await _signInFlow();
    if (result) {
      setState(() {
        Navigator.pop(context);
        HomeScreenRoute().push(context);
      });
    }
  }

  _signOut() async {
    // final response = await profileNotifier.signOut();
  }

  _openSettingsScren() {
    Navigator.pop(context);
    SettingsRoute().push(context);
  }

  Future<bool> _signInFlow() async {
    final authCallbackUrl = await profileNotifier.requestToken();
    return launchUrl(Uri.parse(authCallbackUrl), webOnlyWindowName: '_self');
  }
}
