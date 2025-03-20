import 'package:film_flu/app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({super.key, required this.language});

  final Locale language;

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
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
        Text(
          widget.language.languageCode,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
