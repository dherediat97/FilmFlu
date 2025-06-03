import 'package:film_flu/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String get assetPath => './assets/animations/loading_screen.riv';

  RiveFile? _file;

  @override
  void initState() {
    super.initState();
    preload();
  }

  @override
  Widget build(BuildContext context) {
    return (_file == null)
        ? const SizedBox.shrink()
        : RiveAnimation.direct(
          _file!,
          placeHolder: const Center(child: CircularProgressIndicator()),
          speedMultiplier: 1.20,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          antialiasing: false,
        );
  }

  Future<void> preload() async {
    rootBundle.load(assetPath).then((data) async {
      await RiveFile.initialize();

      // Load the RiveFile from the binary data.
      setState(() {
        _file = RiveFile.import(data);
      });
      Future.delayed(const Duration(seconds: 4), () {
        HomeScreenRoute().pushReplacement(context);
      });
    });
  }
}
