import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String get assetPath => './assets/animations/loading_screen.riv';

  void _onInit(Artboard artboard) {
    var ctrl =
        StateMachineController.fromArtboard(
          artboard,
          artboard.stateMachines.first.name,
        )!;
    ctrl.isActive = false;
    artboard.addController(ctrl);

    var textRun = artboard.textRun('action_label');
    if (textRun != null) {
      textRun.text = '${context.localizations.action_type} !!';
    }
    Future.delayed(const Duration(seconds: 2), () {
      ctrl.isActive = true;
      HomeScreenRoute().pushReplacement(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      assetPath,
      placeHolder: const Center(child: CircularProgressIndicator()),
      animations: ['clapperboard'],
      fit: BoxFit.cover,
      alignment: Alignment.center,
      onInit: _onInit,
    );
  }
}

extension _TextExtension on Artboard {
  TextValueRun? textRun(String name) => component<TextValueRun>(name);
}
