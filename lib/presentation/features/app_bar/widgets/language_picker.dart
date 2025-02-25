import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/presentation/notifiers/app_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class LanguagePicker extends ConsumerStatefulWidget {
  const LanguagePicker({
    super.key,
    required this.language,
    required this.isDropdown,
    this.isMainMenu = false,
  });

  final Locale language;
  final bool isDropdown;
  final bool isMainMenu;

  @override
  ConsumerState<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends ConsumerState<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    final app = ref.watch(appProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            '${AppAssets.flagsFolder}/${widget.language.languageCode}_flag.svg',
            height: 20,
            width: 20,
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(width: 12),
        widget.isMainMenu
            ? Text(
                widget.language.languageCode,
                style: TextStyle(
                  fontSize: 16,
                  color: !app.isDarkMode
                      ? widget.isDropdown
                          ? Colors.black
                          : Colors.black
                      : widget.isDropdown
                          ? Colors.black
                          : Colors.white,
                ),
              )
            : Text(
                widget.language.languageCode,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
      ],
    );
  }
}
