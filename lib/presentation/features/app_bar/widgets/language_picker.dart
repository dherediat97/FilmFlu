import 'package:film_flu/app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguagePicker extends StatefulWidget {
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
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          '${AppAssets.flagsFolder}/${widget.language.languageCode}_flag.svg',
          height: 40,
          width: 20,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: 30),
        widget.isMainMenu
            ? Text(
                widget.language.languageCode,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isDropdown ? Colors.black : Colors.white,
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
