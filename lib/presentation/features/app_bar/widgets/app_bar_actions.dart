import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_urls.dart';
import 'package:film_flu/presentation/features/auth/auth_screen.dart';
import 'package:film_flu/presentation/notifiers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarActions extends ConsumerStatefulWidget {
  const AppBarActions({super.key, required this.isMainMenu});

  final bool isMainMenu;

  @override
  ConsumerState<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends ConsumerState<AppBarActions> {
  Profile get profileNotifier => ref.watch(profileProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    return Row(
      spacing: 16,
      children: [
        IconButton(
          onPressed: () => _openProfileDialogBox(),
          icon: profile.when(
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => const Icon(Icons.error),
            data:
                (profile) => CircleAvatar(
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 20,
                  child: Image.network(
                    '${AppUrls.profileImgBaseUrl}${profile.username}',
                  ),
                ),
          ),
        ),
      ],
    );
  }

  _openProfileDialogBox() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            contentPadding: EdgeInsets.all(8),
            titlePadding: EdgeInsets.all(0),
            icon: IconButton(
              alignment: Alignment.topLeft,
              iconSize: 24,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            actionsAlignment: MainAxisAlignment.start,
            actionsOverflowAlignment: OverflowBarAlignment.start,
            actionsOverflowDirection: VerticalDirection.up,
            title: Image.asset(AppAssets.logoIcon, height: 80, width: 80),
            content: AuthScreen(),
          ),
    );
  }
}
