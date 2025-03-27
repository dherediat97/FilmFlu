import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:film_flu/presentation/features/app_bar/widgets/app_bar_actions.dart';
import 'package:film_flu/presentation/features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(70);

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
          !context.canPop()
              ? IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                icon: Image.asset(AppAssets.logoIcon, fit: BoxFit.fitHeight),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    HomeScreenRoute().go(context);
                  }
                },
              )
              : null,
      actions: [AppBarActions(isMainMenu: context.canPop())],
    );
  }
}
