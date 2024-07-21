import 'package:film_flu/presentation/features/settings/widgets/settings_item.dart';
import 'package:film_flu/presentation/top_blocs/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            appBar: AppBar(
              title: Text(
                'Ajustes',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              bottom: TabBar(
                indicatorColor: Theme.of(context).colorScheme.onPrimary,
                labelColor: Theme.of(context).colorScheme.onPrimary,
                unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.verified_user),
                    text: 'General',
                  ),
                  Tab(
                    icon: Icon(Icons.settings_accessibility),
                    text: 'Avanzado',
                  ),
                  Tab(
                    icon: Icon(Icons.help),
                    text: 'Acerca de',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Row(
                  children: [
                    const SettingsItem(title: 'Idioma'),
                    const Text(
                      'Idioma:',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/flags/${state.locale.languageCode}_flag.svg',
                          height: 20,
                          width: 20,
                        ),
                        Text(
                          state.locale.languageCode,
                        )
                      ],
                    ),
                  ],
                ),
                Container(),
                Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
