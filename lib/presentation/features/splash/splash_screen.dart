import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.route,
  });

  final String route;

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      fullScreenMode: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/splash_animation.json',
              controller: _controller,
              height: MediaQuery.of(context).size.height / 3,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..reverse()
                  ..forward().whenComplete(() {
                    context.pushReplacement(widget.route);
                  });
              },
            ),
            Center(
              child: Text(
                context.localizations.loading_title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
