import 'package:film_flu/app/constants/app_assets.dart';
import 'package:film_flu/app/constants/app_colors.dart';
import 'package:film_flu/app/constants/app_constants.dart';
import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/widgets/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

@Deprecated('Old Widget')
class BottomAppBarOld extends StatefulWidget {
  const BottomAppBarOld({super.key});

  @override
  State<BottomAppBarOld> createState() => _BottomAppBarOldState();
}

@Deprecated('Old Widget State')
class _BottomAppBarOldState extends State<BottomAppBarOld> {
  final today = DateTime.now();
  bool loveTapped = false;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      context.localizations.made_with_love,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loveTapped = !loveTapped;
                    });
                  },
                  child: FlipCard(
                    toggler: !loveTapped,
                    frontCard: SvgPicture.asset(
                      AppAssets.fullHeartIcon,
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.backgroundColorLight,
                        BlendMode.srcIn,
                      ),
                    ),
                    backCard: SvgPicture.asset(
                      AppAssets.fullHeartIcon,
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.andalucianColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Icon(Icons.copyright),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(AppConstants.myGithubPage));
                      },
                      child: Text(
                        '${today.year} @dherediat97',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
