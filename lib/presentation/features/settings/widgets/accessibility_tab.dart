import 'package:color_blindness/color_blindness.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessibilityTab extends ConsumerStatefulWidget {
  const AccessibilityTab({super.key});

  @override
  ConsumerState<AccessibilityTab> createState() => _AccessibilityTabState();
}

class _AccessibilityTabState extends ConsumerState<AccessibilityTab> {
  @override
  Widget build(BuildContext context) {
    final appNotifier = ref.watch(appProvider.notifier);
    final colorBlindnessType = ref.watch(appProvider).appColorBlindessType;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daltonism Types',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.none,
            onChanged: (bool isSelected) {
              appNotifier.changeBlindessTheme(ColorBlindnessType.none);
            },
            title: Text('No colorblindess'),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.achromatopsia,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(
                  ColorBlindnessType.achromatopsia,
                );
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Achromatopsia'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.achromatomaly,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(
                  ColorBlindnessType.achromatomaly,
                );
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Achromatomaly'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.deuteranopia,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(
                  ColorBlindnessType.deuteranopia,
                );
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Deuteranopia'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.deuteranomaly,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(
                  ColorBlindnessType.deuteranomaly,
                );
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Deuteranomaly'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.protanomaly,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(ColorBlindnessType.protanomaly);
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Protanomaly'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.protanopia,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(ColorBlindnessType.protanopia);
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Protanopia'),
          ),
          const Divider(height: 20),
          SwitchListTile(
            value: colorBlindnessType == ColorBlindnessType.tritanopia,
            onChanged: (bool isSelected) {
              if (isSelected) {
                appNotifier.changeBlindessTheme(ColorBlindnessType.tritanopia);
              } else {
                appNotifier.changeBlindessTheme(ColorBlindnessType.none);
              }
            },
            title: Text('Tritanopia'),
          ),
        ],
      ),
    );
  }
}
