import 'package:film_flu/domain/enums/settings_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsProvider extends StateNotifier<SettingsTab> {
  _init() {
    state = SettingsTab.general;
  }

  SettingsProvider() : super(SettingsTab.general) {
    _init();
  }

  void setTabSelected(SettingsTab settingTabSelected) {
    state = settingTabSelected;
  }
}

final settingsProvider = StateNotifierProvider<SettingsProvider, SettingsTab>(
  (ref) => SettingsProvider(),
);
