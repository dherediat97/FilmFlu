import 'package:color_blindness/color_blindness.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedTab extends ConsumerStatefulWidget {
  const AdvancedTab({super.key});

  @override
  ConsumerState<AdvancedTab> createState() => _AdvancedTabState();
}

class _AdvancedTabState extends ConsumerState<AdvancedTab> {
  bool isAchromatopsiaOn = false,
      isAchromatomalyOn = false,
      isDeuteranopiaOn = false,
      isDeuteranomalyOn = false,
      isProtanomalyOn = true,
      isProtanopiaOn = false,
      isTritanopiaOn = false;

  @override
  Widget build(BuildContext context) {
    final appNotifier = ref.watch(appProvider.notifier);
    final appState = ref.watch(appProvider);
    isAchromatopsiaOn =
        appState.appColorBlindessType == ColorBlindnessType.achromatopsia;
    isAchromatomalyOn =
        appState.appColorBlindessType == ColorBlindnessType.achromatomaly;
    isDeuteranopiaOn =
        appState.appColorBlindessType == ColorBlindnessType.deuteranopia;
    isDeuteranomalyOn =
        appState.appColorBlindessType == ColorBlindnessType.deuteranomaly;
    isProtanomalyOn =
        appState.appColorBlindessType == ColorBlindnessType.protanomaly;
    isProtanopiaOn =
        appState.appColorBlindessType == ColorBlindnessType.protanopia;
    isTritanopiaOn =
        appState.appColorBlindessType == ColorBlindnessType.tritanopia;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daltonism Types',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SwitchListTile(
            value: isAchromatopsiaOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isAchromatopsiaOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.achromatopsia);
            },
            title: Text(
              'Achromatopsia ${isAchromatopsiaOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isAchromatomalyOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isAchromatomalyOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.achromatomaly);
            },
            title: Text(
              'Achromatomaly ${isAchromatomalyOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isDeuteranopiaOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isDeuteranopiaOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.deuteranopia);
            },
            title: Text(
              'Deuteranopia ${isDeuteranopiaOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isDeuteranomalyOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isDeuteranomalyOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.deuteranomaly);
            },
            title: Text(
              'Deuteranomaly ${isProtanopiaOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isProtanomalyOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isProtanomalyOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.protanomaly);
            },
            title: Text(
              'Protanomaly ${isProtanomalyOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isProtanopiaOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isProtanopiaOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.protanopia);
            },
            title: Text(
              'Protanopia ${isProtanopiaOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: isTritanopiaOn,
            onChanged: (bool isSelected) {
              setState(() {
                unselectAllColorBlindess();
                isTritanopiaOn = isSelected;
              });
              appNotifier.changeBlindessTheme(ColorBlindnessType.tritanopia);
            },
            title: Text(
              'Tritanopia ${isTritanopiaOn ? 'enabled' : 'disabled'}',
            ),
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }

  void unselectAllColorBlindess() {
    isAchromatomalyOn = false;
    isAchromatopsiaOn = false;
    isDeuteranomalyOn = false;
    isDeuteranopiaOn = false;
    isProtanopiaOn = false;
    isProtanomalyOn = false;
    isTritanopiaOn = false;
  }
}
