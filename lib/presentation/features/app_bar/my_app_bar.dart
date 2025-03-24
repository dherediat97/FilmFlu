import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/routes/app_paths.dart';
import 'package:film_flu/domain/enums/media_types.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/app_bar_actions.dart';
import 'package:film_flu/presentation/features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const TopAppBar({
    super.key,
    this.mediaTypeSelected = MediaType.movie,
    this.isMainMenu = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(70);

  final MediaType? mediaTypeSelected;
  final bool isMainMenu;

  @override
  ConsumerState createState() => _TopAppBarState();
}

class _TopAppBarState extends ConsumerState<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchView(),
      automaticallyImplyLeading: true,
      titleTextStyle: Theme.of(context).textTheme.headlineLarge,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      leadingWidth: 80,
      leading:
          widget.isMainMenu
              ? IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                icon: Image.asset(AppAssets.logoIcon, fit: BoxFit.fitHeight),
                onPressed: () {
                  if (!widget.isMainMenu) {
                    context.pop();
                  } else {
                    context.go(AppRoutePaths.homeRoute);
                  }
                },
              )
              : null,
      actions: [AppBarActions(isMainMenu: widget.isMainMenu)],
    );
  }
}
